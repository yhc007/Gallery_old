#!/usr/bin/env bash
# Phase 2/3 — 소스 DB 덤프 → 로컬 MariaDB 복원 → 검증
# 본 서버에서 root 로 실행.  ssh root@jaguar.s4g.kr 'bash -s' < deploy/22-db-dump-restore.sh [--final]
#
# 기본(리허설): --single-transaction 무락 덤프(운영 무중단). InnoDB 일관, MyISAM 비일관(검증용).
# --final     : 컷오버용. Tomcat 정지(쓰기 없음) 전제 → MyISAM 포함 일관. (호출 전 systemctl stop tomcat9)
# charset 혼재(utf8/latin1/ucs2/utf8mb4) 보존 위해 --default-character-set=binary 사용.
set -euo pipefail
[ "$(id -u)" = "0" ] || { echo "root 로 실행하세요"; exit 1; }

MODE="rehearsal"; [ "${1:-}" = "--final" ] && MODE="final"
ENV_FILE="${ENV_FILE:-/var/lib/tomcat9/.env}"; [ -f "$ENV_FILE" ] || ENV_FILE="/opt/gallery/.env"
DB_URL=$(grep -E '^DB_URL=' "$ENV_FILE" | head -1 | cut -d= -f2-)
SRC_USER=$(grep -E '^DB_USERNAME=' "$ENV_FILE" | head -1 | cut -d= -f2-)
SRC_PASS=$(grep -E '^DB_PASSWORD=' "$ENV_FILE" | head -1 | cut -d= -f2-)
HP=$(printf '%s' "$DB_URL" | sed -E 's|^jdbc:mysql://([^/]+)/.*|\1|')
DBNAME=$(printf '%s' "$DB_URL" | sed -E 's|^jdbc:mysql://[^/]+/([^?]+).*|\1|')
SRC_HOST="${HP%%:*}"; SRC_PORT="${HP##*:}"; [ "$SRC_PORT" = "$SRC_HOST" ] && SRC_PORT=3306
WORK="${WORK:-/opt/gallery/migrate}"; mkdir -p "$WORK"
DUMP="$WORK/${DBNAME}_${MODE}.sql"

echo "### 모드: $MODE | 소스 ${SRC_HOST}:${SRC_PORT}/$DBNAME → 로컬 ###"
[ "$MODE" = "final" ] && { systemctl is-active --quiet tomcat9 && { echo "!! 최종 모드인데 tomcat9 가 떠있음. 먼저 'systemctl stop tomcat9' 후 재실행"; exit 1; } || true; }

echo "### 1) 디스크 여유 확인 ###"; df -h "$WORK" | tail -1
echo "### 2) 덤프 (binary charset) ###"
SECONDS=0
MYSQL_PWD="$SRC_PASS" mysqldump -h "$SRC_HOST" -P "$SRC_PORT" -u "$SRC_USER" \
  --single-transaction --quick --routines --triggers --events \
  --default-character-set=binary --hex-blob \
  --databases "$DBNAME" > "$DUMP"
echo "덤프 완료: $(du -h "$DUMP" | cut -f1), ${SECONDS}s"

echo "### 3) 로컬 복원 (drop/recreate) ###"
SECONDS=0
mysql -e "DROP DATABASE IF EXISTS \`$DBNAME\`; CREATE DATABASE \`$DBNAME\` CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql --default-character-set=binary "$DBNAME" < "$DUMP"
# 유저 권한 재부여(덤프가 DB를 재생성하므로)
SRC_USER_ESC="$SRC_USER"
mysql -e "GRANT ALL PRIVILEGES ON \`$DBNAME\`.* TO '$SRC_USER_ESC'@'localhost'; GRANT ALL PRIVILEGES ON \`$DBNAME\`.* TO '$SRC_USER_ESC'@'127.0.0.1'; FLUSH PRIVILEGES;"
echo "복원 완료: ${SECONDS}s"

echo "### 4) 검증 — 테이블 수 ###"
SRC="MYSQL_PWD=$SRC_PASS mysql -h $SRC_HOST -P $SRC_PORT -u $SRC_USER -N -B"
LOC="mysql -N -B"
st=$(eval "$SRC" -e "\"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DBNAME' AND table_type='BASE TABLE'\"")
lt=$(eval "$LOC" -e "\"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DBNAME' AND table_type='BASE TABLE'\"")
echo "소스 테이블 $st / 로컬 테이블 $lt"; [ "$st" = "$lt" ] && echo "  ✅ 일치" || echo "  ❌ 불일치"

echo "### 5) 검증 — 테이블별 행수 비교(정확 COUNT, 다소 소요) ###"
TABLES=$(eval "$LOC" -e "\"SELECT table_name FROM information_schema.tables WHERE table_schema='$DBNAME' AND table_type='BASE TABLE' ORDER BY table_name\"")
mismatch=0
for t in $TABLES; do
  sc=$(eval "$SRC" -e "\"SELECT COUNT(*) FROM \\\`$DBNAME\\\`.\\\`$t\\\`\"")
  lc=$(eval "$LOC" -e "\"SELECT COUNT(*) FROM \\\`$DBNAME\\\`.\\\`$t\\\`\"")
  if [ "$sc" != "$lc" ]; then echo "  ❌ $t  소스=$sc 로컬=$lc"; mismatch=$((mismatch+1)); fi
done
[ "$mismatch" = 0 ] && echo "  ✅ 모든 테이블 행수 일치" || echo "  ❌ 불일치 $mismatch 개 테이블"

echo "### 6) 검증 — 한글 표본(cstmr 상위 5건, 깨짐 육안 확인) ###"
eval "$LOC" -e "\"SELECT cstmr_id, cstmr_name FROM \\\`$DBNAME\\\`.cstmr ORDER BY cstmr_id DESC LIMIT 5\"" 2>/dev/null || echo "(cstmr 테이블/컬럼명 확인 필요)"

echo
echo "### 요약 ###"
echo " 모드=$MODE 덤프=$DUMP 테이블 $st/$lt 행수불일치=$mismatch"
[ "$st" = "$lt" ] && [ "$mismatch" = 0 ] && echo " ✅ 검증 통과" || echo " ❌ 검증 실패 — 원인 확인(charset/엔진/권한)"
