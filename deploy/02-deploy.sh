#!/usr/bin/env bash
# 빌드 산출물을 서버에 업로드하고 재시작합니다.
#  - gallery-manager : Tomcat webapps 에 war 배포 후 Tomcat 재시작
#  - board/staff/talk : jar 업로드 후 기존 프로세스 종료 → 재기동
# 덮어쓰기 전에 항상 백업(.bak-<timestamp>)을 남깁니다(롤백용).
set -euo pipefail
cd "$(dirname "$0")"
[ -f config.env ] || { echo "config.env 가 없습니다. config.env.example 을 복사해 채우세요."; exit 1; }
# shellcheck disable=SC1091
source config.env
ROOT="$(cd .. && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"

SSH_OPTS=(-p "$SSH_PORT"); SCP_OPTS=(-P "$SSH_PORT")
if [ -n "${SSH_KEY:-}" ]; then SSH_OPTS+=(-i "$SSH_KEY"); SCP_OPTS+=(-i "$SSH_KEY"); fi
SSH=(ssh "${SSH_OPTS[@]}" "${SSH_USER}@${SSH_HOST}")
JAVA_BIN="${REMOTE_JAVA:-java}"

# 산출물 존재 확인
BOARD_JAR="$ROOT/gallery-board/build/libs/gallery-board-0.0.1-SNAPSHOT.jar"
STAFF_JAR="$ROOT/gallery-staff/build/libs/gallery-staff-0.0.1-SNAPSHOT.jar"
TALK_JAR="$ROOT/gallery-talk/build/libs/gallery-talk-0.0.1-SNAPSHOT.jar"
MANAGER_WAR="$ROOT/gallery-manager/build/libs/ROOT.war"
for f in "$BOARD_JAR" "$STAFF_JAR" "$TALK_JAR" "$MANAGER_WAR"; do
  [ -f "$f" ] || { echo "산출물 없음: $f  → 먼저 ./01-build.sh 실행"; exit 1; }
done

echo "### 1) 원격 디렉터리 준비 ###"
"${SSH[@]}" "mkdir -p '$REMOTE_APP_DIR' '$REMOTE_APP_DIR/backup'"

deploy_jar () {  # $1=로컬jar  $2=원격파일명  $3=포트
  local local_jar="$1" name="$2" port="$3"
  local remote="$REMOTE_APP_DIR/$name"
  echo "--- [$name] 업로드 (port $port) ---"
  # 기존 jar 백업
  "${SSH[@]}" "[ -f '$remote' ] && cp '$remote' '$REMOTE_APP_DIR/backup/${name}.bak-$TS' || true"
  scp "${SCP_OPTS[@]}" "$local_jar" "${SSH_USER}@${SSH_HOST}:$remote"
  echo "--- [$name] 기존 프로세스 종료 후 재기동 ---"
  "${SSH[@]}" "bash -s" <<EOF
    set -e
    pids=\$(pgrep -f '$name' || true)
    if [ -n "\$pids" ]; then echo "kill \$pids"; kill \$pids; sleep 5; kill -9 \$pids 2>/dev/null || true; fi
    cd '$REMOTE_APP_DIR'
    nohup '$JAVA_BIN' -jar '$remote' --server.port=$port > '$REMOTE_APP_DIR/${name}.log' 2>&1 &
    sleep 3
    echo "재기동됨. 최근 로그:"; tail -n 15 '$REMOTE_APP_DIR/${name}.log' || true
EOF
}

echo "### 2) 실행형 jar 3종 배포 ###"
deploy_jar "$BOARD_JAR" "gallery-board.jar" "$BOARD_PORT"
deploy_jar "$STAFF_JAR" "gallery-staff.jar" "$STAFF_PORT"
deploy_jar "$TALK_JAR"  "gallery-talk.jar"  "$TALK_PORT"

echo "### 3) gallery-manager war → Tomcat 배포 ###"
WAR_DEST="$TOMCAT_WEBAPPS/$MANAGER_WAR_NAME"
EXPLODED="$TOMCAT_WEBAPPS/${MANAGER_WAR_NAME%.war}"
"${SSH[@]}" "bash -s" <<EOF
  set -e
  # 기존 war + 압축해제 디렉터리 백업
  [ -f '$WAR_DEST' ] && cp '$WAR_DEST' '$REMOTE_APP_DIR/backup/${MANAGER_WAR_NAME}.bak-$TS' || true
  [ -d '$EXPLODED' ] && mv '$EXPLODED' '$REMOTE_APP_DIR/backup/${MANAGER_WAR_NAME%.war}.bak-$TS' || true
EOF
scp "${SCP_OPTS[@]}" "$MANAGER_WAR" "${SSH_USER}@${SSH_HOST}:$WAR_DEST"
echo "--- Tomcat 재시작 ---"
"${SSH[@]}" "$TOMCAT_RESTART_CMD"

echo
echo "### 완료 (백업: $REMOTE_APP_DIR/backup/*.bak-$TS) ###"
echo "확인:"
echo "  - https://jaguar.s4g.kr/  (board)"
echo "  - https://jaguar.s4g.kr/Manager/admin/login.do  (manager)"
echo "롤백이 필요하면 backup 폴더의 .bak-$TS 파일을 원위치로 되돌리고 재시작하세요."
