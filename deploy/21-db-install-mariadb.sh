#!/usr/bin/env bash
# Phase 1 — 본 서버에 MariaDB 10.6 설치·튜닝·DB/유저 생성
# 전제: RAM 증설(4GB) 완료 후 실행. 본 서버(jaguar.s4g.kr)에서 root 로 실행.
#   ssh root@jaguar.s4g.kr 'bash -s' < deploy/21-db-install-mariadb.sh
#
# 로컬 DB 비밀번호는 소스 .env 의 DB_PASSWORD 를 재사용한다(컷오버 시 DB_URL 호스트만 변경).
set -euo pipefail
[ "$(id -u)" = "0" ] || { echo "root 로 실행하세요"; exit 1; }

ENV_FILE="${ENV_FILE:-/var/lib/tomcat9/.env}"; [ -f "$ENV_FILE" ] || ENV_FILE="/opt/gallery/.env"
[ -f "$ENV_FILE" ] || { echo "ERROR: .env 없음"; exit 1; }
DB_PASS=$(grep -E '^DB_PASSWORD=' "$ENV_FILE" | head -1 | cut -d= -f2-)
DB_USER=$(grep -E '^DB_USERNAME=' "$ENV_FILE" | head -1 | cut -d= -f2-)
DBNAME="${DBNAME:-gallery_op}"
BUFFER_POOL="${BUFFER_POOL:-1G}"     # 증설 후 free 보고 1G~1.5G 조정

echo "### 1) RAM 확인 (4GB 증설 반영 여부) ###"; free -h
echo "### 2) MariaDB 10.6 설치 ###"
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y mariadb-server mariadb-client
mysql --version

echo "### 3) 튜닝 설정 작성 ###"
cat > /etc/mysql/mariadb.conf.d/99-gallery.cnf <<CNF
[mysqld]
bind-address            = 127.0.0.1
innodb_buffer_pool_size = ${BUFFER_POOL}
performance_schema      = OFF
max_connections         = 100
skip-name-resolve       = 1
character-set-server    = utf8
collation-server        = utf8_general_ci
# 소스(10.1)의 느슨한 동작과 일치 — 제로 날짜(0000-00-00) 등 레거시 데이터 허용
sql_mode                = NO_ENGINE_SUBSTITUTION
innodb_file_per_table   = 1
# 소스(10.1)는 innodb_strict_mode OFF 라 ROW_FORMAT=COMPACT 대형 행 테이블(예: lens_detail_copy,
# varchar(255) 다수) 생성을 허용. 10.6 기본 ON 이면 복원 시 "Row size too large(>8126)" 에러.
# → 소스와 동일하게 OFF 로 두어 덤프를 원형 그대로 복원(데이터 무손실, DDL 엄격성만 완화).
innodb_strict_mode      = OFF
CNF

systemctl restart mariadb
systemctl enable mariadb
systemctl is-active mariadb

echo "### 4) DB/유저 생성 (charset 소스와 일치, TCP/소켓 양쪽 호스트) ###"
mysql <<SQL
CREATE DATABASE IF NOT EXISTS \`${DBNAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost'  IDENTIFIED BY '${DB_PASS}';
CREATE USER IF NOT EXISTS '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DBNAME}\`.* TO '${DB_USER}'@'localhost';
GRANT ALL PRIVILEGES ON \`${DBNAME}\`.* TO '${DB_USER}'@'127.0.0.1';
FLUSH PRIVILEGES;
SQL

echo "### 5) 확인 ###"
mysql -e "SELECT @@version, @@innodb_buffer_pool_size/1024/1024 AS pool_mb, @@sql_mode, @@character_set_server;"
mysql -e "SHOW DATABASES LIKE '${DBNAME}';"
echo "완료. 다음: 22-db-dump-restore.sh (리허설)"
