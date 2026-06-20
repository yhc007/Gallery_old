#!/usr/bin/env bash
# Phase 0 — DB 이전 사전조사 (읽기전용, 무중단)
# 본 서버에서 실행한다. 운영 .env 의 DB 접속정보로 소스 DB 메타데이터와
# 본 서버 자원을 조사한다. 비밀번호는 출력하지 않는다.
#
# 사용(서버에서):  bash 20-db-phase0-survey.sh
# 또는 로컬에서:    ssh root@jaguar.s4g.kr 'bash -s' < deploy/20-db-phase0-survey.sh
set -uo pipefail

ENV_FILE="${ENV_FILE:-/var/lib/tomcat9/.env}"
[ -f "$ENV_FILE" ] || ENV_FILE="/opt/gallery/.env"
[ -f "$ENV_FILE" ] || { echo "ERROR: .env 없음 (/var/lib/tomcat9/.env, /opt/gallery/.env)"; exit 1; }

# .env 파싱 (출력하지 않음)
DB_URL=$(grep -E '^DB_URL=' "$ENV_FILE" | head -1 | cut -d= -f2-)
DB_USER=$(grep -E '^DB_USERNAME=' "$ENV_FILE" | head -1 | cut -d= -f2-)
DB_PASS=$(grep -E '^DB_PASSWORD=' "$ENV_FILE" | head -1 | cut -d= -f2-)

# jdbc:mysql://host:port/db?params  →  host, port, db
HOSTPORT=$(printf '%s' "$DB_URL" | sed -E 's|^jdbc:mysql://([^/]+)/.*|\1|')
DBNAME=$(printf '%s'   "$DB_URL" | sed -E 's|^jdbc:mysql://[^/]+/([^?]+).*|\1|')
HOST="${HOSTPORT%%:*}"
PORT="${HOSTPORT##*:}"; [ "$PORT" = "$HOST" ] && PORT=3306

echo "### 소스 DB: ${HOST}:${PORT}  db=${DBNAME}  user=${DB_USER} (비번 미출력) ###"
# MYSQL_PWD 로 비번을 argv 에 노출하지 않음
run() { MYSQL_PWD="$DB_PASS" mysql -h "$HOST" -P "$PORT" -u "$DB_USER" --connect-timeout=10 -N -B -e "$1" 2>&1; }

echo "== 버전 =="; run "SELECT VERSION();"
echo "== 총 용량(MB) / 테이블 수 =="
run "SELECT ROUND(SUM(data_length+index_length)/1024/1024,1) AS data_mb, COUNT(*) AS tables FROM information_schema.tables WHERE table_schema='${DBNAME}';"
echo "== 스토리지 엔진 분포 =="
run "SELECT IFNULL(engine,'(view)') eng, COUNT(*) FROM information_schema.tables WHERE table_schema='${DBNAME}' GROUP BY engine;"
echo "== DB 기본 charset/collation =="
run "SELECT default_character_set_name, default_collation_name FROM information_schema.schemata WHERE schema_name='${DBNAME}';"
echo "== 컬럼 charset 분포(혹시 혼재) =="
run "SELECT character_set_name, COUNT(*) FROM information_schema.columns WHERE table_schema='${DBNAME}' AND character_set_name IS NOT NULL GROUP BY character_set_name;"
echo "== 상위 10개 큰 테이블 =="
run "SELECT table_name, ROUND((data_length+index_length)/1024/1024,1) mb, table_rows FROM information_schema.tables WHERE table_schema='${DBNAME}' ORDER BY (data_length+index_length) DESC LIMIT 10;"

echo
echo "### 본 서버 자원 ###"
echo "== 디스크(/ , /var) =="; df -h / /var 2>/dev/null
echo "== 메모리 =="; free -h
echo "== swap =="; swapon --show 2>/dev/null || echo "(swap 정보 없음)"
echo "== 현재 java(Tomcat) RSS 합 =="; ps -o rss= -C java 2>/dev/null | awk '{s+=$1} END{printf "%.0f MB\n", s/1024}'
echo "== 로컬 MariaDB/MySQL 설치 여부 =="; dpkg -l 2>/dev/null | grep -iE 'mariadb-server|mysql-server' | awk '{print $1,$2,$3}' || echo "(미설치)"
echo
echo "### 판정 가이드 ###"
echo " - data_mb <= ~2000  → 4GB + buffer_pool 256M 로 충분"
echo " - data_mb >= ~10000 → 4GB 부족, 8GB 증설 회귀 검토 (buffer_pool 을 핫셋 기준 재산정)"
echo " - 엔진에 MyISAM 있으면 최종 덤프는 점검창에서 --lock-all-tables 필요"
echo " - 디스크 여유는 data_mb 의 2~3배 이상 확보 필요(덤프+복원)"
