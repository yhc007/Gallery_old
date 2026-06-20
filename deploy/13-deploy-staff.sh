#!/usr/bin/env bash
# gallery-staff(GalleryStaff.war) 한 모듈만 운영 Tomcat9 에 배포한다.
# 운영 모델: 4개 war 를 단일 Tomcat9(/var/lib/tomcat9/webapps)에 올린 구성.
# 다른 3개 앱(board/talk/manager)은 건드리지 않고 staff 컨텍스트만 교체한다.
# 덮어쓰기 전 항상 백업(.bak-<timestamp>)을 남긴다(롤백용).
#
# 사용:
#   JDK11 로 빌드 후 실행 →  ./deploy/01-build.sh  또는
#     JAVA_HOME=<corretto11> ./gradlew :gallery-staff:bootWar -x test
#   그 다음:
#     SSH_HOST=jaguar.s4g.kr ./deploy/13-deploy-staff.sh
#   (SSH_HOST 를 운영 서버 호스트로 반드시 확인해서 지정할 것)
set -euo pipefail
cd "$(dirname "$0")/.."

# ── 접속/경로 설정 (환경변수로 덮어쓰기 가능) ──
SSH_USER="${SSH_USER:-root}"
SSH_HOST="${SSH_HOST:?SSH_HOST 를 지정하세요 (예: SSH_HOST=jaguar.s4g.kr)}"
SSH_PORT="${SSH_PORT:-22}"
SSH_KEY="${SSH_KEY:-}"                       # 비우면 기본 키 사용
WEBAPPS="${WEBAPPS:-/var/lib/tomcat9/webapps}"
APP_DIR="${APP_DIR:-/opt/gallery}"           # war 원본/백업 보관 위치
WAR_NAME="GalleryStaff.war"                  # 컨텍스트 /GalleryStaff
TOMCAT_USER="${TOMCAT_USER:-tomcat}"
CATALINA_LOG="${CATALINA_LOG:-/var/log/tomcat9/catalina.out}"

LOCAL_WAR="gallery-staff/build/libs/${WAR_NAME}"
[ -f "$LOCAL_WAR" ] || { echo "산출물 없음: $LOCAL_WAR  → 먼저 JDK11 로 :gallery-staff:bootWar 빌드"; exit 1; }

SSH_OPTS=(-p "$SSH_PORT"); SCP_OPTS=(-P "$SSH_PORT")
[ -n "$SSH_KEY" ] && { SSH_OPTS+=(-i "$SSH_KEY"); SCP_OPTS+=(-i "$SSH_KEY"); }
SSH=(ssh "${SSH_OPTS[@]}" "${SSH_USER}@${SSH_HOST}")
TS="$(date +%Y%m%d-%H%M%S)"

echo "### 0) 대상 확인: ${SSH_USER}@${SSH_HOST}:${SSH_PORT}  webapps=${WEBAPPS} ###"
"${SSH[@]}" "ls -la '$WEBAPPS' | grep -i gallerystaff || echo '(기존 GalleryStaff 없음 — 신규 배포)'"

echo "### 1) war 업로드 → ${APP_DIR}/${WAR_NAME} (백업 보존) ###"
"${SSH[@]}" "mkdir -p '$APP_DIR/backup'"
scp "${SCP_OPTS[@]}" "$LOCAL_WAR" "${SSH_USER}@${SSH_HOST}:/tmp/${WAR_NAME}.new"

echo "### 2) 백업 + 배포 + 검증 ###"
"${SSH[@]}" "bash -s" <<EOF
  set -e
  W='$WEBAPPS'; APP='$APP_DIR'; NAME='$WAR_NAME'; TS='$TS'
  # 현재 war + 전개 디렉터리 백업
  [ -f "\$W/\$NAME" ] && cp "\$W/\$NAME" "\$APP/backup/\${NAME}.bak-\$TS" && echo "백업: \$APP/backup/\${NAME}.bak-\$TS" || true
  [ -d "\$W/\${NAME%.war}" ] && tar czf "\$APP/backup/\${NAME%.war}-exploded.bak-\$TS.tgz" -C "\$W" "\${NAME%.war}" 2>/dev/null && echo "백업(exploded): \$APP/backup/\${NAME%.war}-exploded.bak-\$TS.tgz" || true
  # 원본 보관 + 배포
  cp "/tmp/\${NAME}.new" "\$APP/\$NAME"
  chown ${TOMCAT_USER}:${TOMCAT_USER} "\$APP/\$NAME" 2>/dev/null || true
  rm -rf "\$W/\${NAME%.war}"           # 기존 전개본 제거(autoDeploy 재전개 유도)
  cp "\$APP/\$NAME" "\$W/\$NAME"
  chown ${TOMCAT_USER}:${TOMCAT_USER} "\$W/\$NAME" 2>/dev/null || true
  rm -f "/tmp/\${NAME}.new"
  echo "배포 파일 반영됨. autoDeploy 대기..."
  sleep 20
  ls -la "\$W" | grep -i gallerystaff || true
  echo "--- 최근 catalina 로그(staff/에러) ---"
  tail -n 120 '$CATALINA_LOG' 2>/dev/null | grep -iE 'gallerystaff|deploy|error|exception' | tail -20 || echo "(로그 경로 확인 필요: $CATALINA_LOG)"
  code=\$(curl -s -o /dev/null -w '%{http_code}' -L http://127.0.0.1:8080/GalleryStaff/ || echo 000)
  echo "GalleryStaff 로컬 응답: http=\$code"
  if [ "\$code" != "200" ] && [ "\$code" != "302" ]; then
    echo "!! 컨텍스트가 정상 응답하지 않음. autoDeploy 미동작 가능 → Tomcat 재시작 시도(전체 앱 잠깐 중단)"
    systemctl restart tomcat9 || { echo "systemctl restart 실패 — 수동 확인 필요"; exit 1; }
    sleep 25
    code=\$(curl -s -o /dev/null -w '%{http_code}' -L http://127.0.0.1:8080/GalleryStaff/ || echo 000)
    echo "재시작 후 GalleryStaff 응답: http=\$code"
  fi
EOF

echo
echo "### 완료 ###"
echo "확인: https://${SSH_HOST}/GalleryStaff/  (매장고객 검색 → 고객 선택 시 '실패. 재시도' 사라졌는지)"
echo "롤백: 서버 ${APP_DIR}/backup/${WAR_NAME}.bak-${TS} 를 ${WEBAPPS}/${WAR_NAME} 로 복원 후 재시작"
