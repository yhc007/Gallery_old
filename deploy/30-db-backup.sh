#!/usr/bin/env bash
# Phase 4 — 로컬 gallery_op 자동 백업 (일 1회 cron). mysqldump → gzip → 회전.
# cron 에서 root 로 실행(소켓 인증). 수동:  bash deploy/30-db-backup.sh
#   환경변수로 조정: DBNAME, BACKUP_DIR, RETENTION_DAYS, MIN_FREE_GB
set -euo pipefail

DBNAME="${DBNAME:-gallery_op}"
BACKUP_DIR="${BACKUP_DIR:-/opt/gallery/backups}"
RETENTION_DAYS="${RETENTION_DAYS:-7}"     # 디스크 여유 보고 조정. 8GB DB라 gz ~2GB/일.
MIN_FREE_GB="${MIN_FREE_GB:-8}"           # 백업 전 최소 여유. 미만이면 중단(부분백업·디스크풀 방지).
mkdir -p "$BACKUP_DIR"
LOG="$BACKUP_DIR/backup.log"
TS="$(date +%Y%m%d-%H%M%S)"
OUT="$BACKUP_DIR/${DBNAME}_${TS}.sql.gz"

log() { echo "[$(date '+%F %T')] $*" | tee -a "$LOG"; }

# 1) 디스크 가드
AVAIL_KB=$(df -P "$BACKUP_DIR" | awk 'NR==2{print $4}')
if [ "$AVAIL_KB" -lt $((MIN_FREE_GB*1024*1024)) ]; then
  log "❌ 디스크 여유 $((AVAIL_KB/1024/1024))GB < ${MIN_FREE_GB}GB — 백업 중단"; exit 1
fi

# 2) 덤프(로컬 소켓, InnoDB 무락 일관 스냅샷, charset 보존 binary).
#    ※ MyISAM 15개(clens/lens 등 정적 참조테이블)는 --single-transaction 보호 밖이나 거의 불변이라 허용.
log "백업 시작 → $OUT"
if mysqldump --single-transaction --quick --routines --triggers --events \
      --default-character-set=binary --hex-blob "$DBNAME" | gzip -c > "$OUT"; then
  log "✅ 완료 $(du -h "$OUT" | cut -f1)"
else
  log "❌ mysqldump 실패 — 불완전 파일 삭제"; rm -f "$OUT"; exit 1
fi

# 3) 회전: RETENTION_DAYS 보다 오래된 백업 삭제
find "$BACKUP_DIR" -name "${DBNAME}_*.sql.gz" -type f -mtime +"$RETENTION_DAYS" -print -delete \
  | while read -r f; do log "회전 삭제: $f"; done

log "보관 $(ls -1 "$BACKUP_DIR"/${DBNAME}_*.sql.gz 2>/dev/null | wc -l)개 / 총 $(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)"
