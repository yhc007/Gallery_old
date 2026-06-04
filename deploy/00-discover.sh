#!/usr/bin/env bash
# 서버 현황 파악용. 실제 배포 전에 한 번 실행해서 경로/포트/실행방식을 확인하세요.
# 아무것도 변경하지 않고 정보만 출력합니다(read-only).
set -uo pipefail
cd "$(dirname "$0")"
[ -f config.env ] || { echo "config.env 가 없습니다. config.env.example 을 복사해 채우세요."; exit 1; }
# shellcheck disable=SC1091
source config.env

SSH_OPTS=(-p "$SSH_PORT")
[ -n "${SSH_KEY:-}" ] && SSH_OPTS+=(-i "$SSH_KEY")

echo "### ${SSH_USER}@${SSH_HOST}:${SSH_PORT} 현황 조회 ###"
ssh "${SSH_OPTS[@]}" "${SSH_USER}@${SSH_HOST}" \
  "REMOTE_APP_DIR='${REMOTE_APP_DIR:-}' TOMCAT_WEBAPPS='${TOMCAT_WEBAPPS:-}' MANAGER_WAR_NAME='${MANAGER_WAR_NAME:-ROOT.war}' bash -s" <<'REMOTE'
echo "===== java 버전 ====="; java -version 2>&1; echo
echo "===== 실행 중인 java 프로세스 ====="; ps -ef | grep -i '[j]ava' ; echo
echo "===== LISTEN 포트 ====="; (ss -ltnp 2>/dev/null || netstat -ltnp 2>/dev/null) | grep -i java ; echo
echo "===== Tomcat 후보 경로 ====="; ls -d /usr/local/tomcat* /opt/tomcat* /usr/share/tomcat* 2>/dev/null; echo
echo "===== Tomcat webapps 내용 ====="; for d in /usr/local/tomcat/webapps /opt/tomcat/webapps; do [ -d "$d" ] && { echo "[$d]"; ls -la "$d"; }; done; echo
echo "===== systemd 서비스(tomcat/gallery) ====="; systemctl list-units --type=service 2>/dev/null | grep -iE 'tomcat|gallery' || echo "(systemd 없음/해당 없음)"; echo
echo "===== nginx/apache 설치 여부 ====="; nginx -v 2>&1; httpd -v 2>&1; echo
echo "===== SSL 인증서(letsencrypt) ====="; ls -d /etc/letsencrypt/live/* 2>/dev/null || echo "(letsencrypt 없음)"; echo
echo "===== nginx server_name / proxy_pass 매핑 ====="; grep -rEn 'server_name|proxy_pass' /etc/nginx 2>/dev/null | grep -vi '#' | head -40 || echo "(nginx conf 없음)"; echo

echo "===== .env 위치 점검 (값은 마스킹, 키만 표시) ====="
# 점검 후보: jar 실행 디렉터리, Tomcat 작업/홈 디렉터리, 흔한 위치 + 광역 탐색
TOMCAT_HOME=""
for t in /usr/local/tomcat /opt/tomcat /usr/share/tomcat; do [ -d "$t" ] && TOMCAT_HOME="$t" && break; done
[ -n "$TOMCAT_WEBAPPS" ] && [ -z "$TOMCAT_HOME" ] && TOMCAT_HOME="$(dirname "$TOMCAT_WEBAPPS")"
CANDS=()
[ -n "$REMOTE_APP_DIR" ] && CANDS+=("$REMOTE_APP_DIR/.env")
[ -n "$TOMCAT_HOME" ] && CANDS+=("$TOMCAT_HOME/.env" "$TOMCAT_HOME/bin/.env")
CANDS+=("$HOME/.env" "/home/gallery/apps/.env" "$(pwd)/.env")
# 광역 탐색(시간제한): apps/tomcat 하위에서 .env 추가 발견
FOUND_EXTRA=$(find /home /usr/local /opt -maxdepth 4 -name '.env' -type f 2>/dev/null)
for e in $FOUND_EXTRA; do CANDS+=("$e"); done

# 중복 제거 후 출력
printf '%s\n' "${CANDS[@]}" | awk '!seen[$0]++' | while read -r ENVF; do
  [ -n "$ENVF" ] || continue
  if [ -f "$ENVF" ]; then
    echo "[발견] $ENVF"
    # DB_URL 은 호스트/DB명 확인이 중요하므로 비밀번호만 가리고 표기
    while IFS= read -r line; do
      case "$line" in
        ''|\#*) continue;;
        DB_PASSWORD=*|*PASSWORD=*|*SECRET*=*|*KEY=*)
          k="${line%%=*}"; v="${line#*=}"
          if [ -n "$v" ]; then echo "    $k=********(설정됨)"; else echo "    $k=(비어있음)"; fi;;
        DB_URL=*)
          echo "    $line";;
        *)
          k="${line%%=*}"; v="${line#*=}"
          if [ -n "$v" ]; then echo "    $k=(설정됨)"; else echo "    $k=(비어있음)"; fi;;
      esac
    done < "$ENVF"
  else
    echo "[없음]   $ENVF"
  fi
done
echo
echo "  → 각 실행형 jar 은 '실행 디렉터리'의 .env 를, manager(war)는 Tomcat 작업 디렉터리의 .env 를 읽습니다."
echo "    위에서 jar 배포 위치(REMOTE_APP_DIR)와 Tomcat 홈에 .env 가 있는지 확인하세요."
REMOTE
