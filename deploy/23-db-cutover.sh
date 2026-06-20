#!/usr/bin/env bash
# Phase 3 — 컷오버: Tomcat 정지 → 최종 덤프/복원 → .env 전환 → 기동 → 헬스체크 (+ 롤백)
# 본 서버에서 root 로 실행(점검창). 전제: 21(설치)·22 리허설 통과.
#   ssh root@jaguar.s4g.kr 'bash -s' < deploy/23-db-cutover.sh
# 다운타임 ≈ 덤프+복원 시간(리허설에서 측정한 값). 실패 시 자동 롤백.
set -euo pipefail
[ "$(id -u)" = "0" ] || { echo "root 로 실행하세요"; exit 1; }
cd "$(dirname "$0")"

ENVS=(/var/lib/tomcat9/.env /opt/gallery/.env)
ENV_MAIN=""; for f in "${ENVS[@]}"; do [ -f "$f" ] && ENV_MAIN="$f" && break; done
[ -n "$ENV_MAIN" ] || { echo "ERROR: .env 없음"; exit 1; }
DB_URL=$(grep -E '^DB_URL=' "$ENV_MAIN" | head -1 | cut -d= -f2-)
SRC_HOST=$(printf '%s' "$DB_URL" | sed -E 's|^jdbc:mysql://([^:/]+).*|\1|')
TS="$(date +%Y%m%d-%H%M%S)"
echo "### 소스 호스트 '$SRC_HOST' → '127.0.0.1' 로 전환 예정. 다운타임 시작. ###"

rollback() {
  echo "!!! 롤백: .env 원복 + Tomcat 재기동 (소스=cafe24 DB 로 복귀) !!!"
  for f in "${ENVS[@]}"; do [ -f "$f.bak-$TS" ] && cp "$f.bak-$TS" "$f"; done
  systemctl start tomcat9 || true
  echo "롤백 완료. 데이터는 cafe24 운영 DB 그대로."
}

echo "### 1) Tomcat 정지(쓰기 차단) ###"
systemctl stop tomcat9; sleep 3

echo "### 2) 최종 덤프 → 로컬 복원 + 검증 ###"
if ! bash ./22-db-dump-restore.sh --final; then echo "덤프/복원/검증 실패"; rollback; exit 1; fi

echo "### 3) .env 전환 (백업 후 DB_URL 호스트 교체) ###"
for f in "${ENVS[@]}"; do
  [ -f "$f" ] || continue
  cp "$f" "$f.bak-$TS"
  sed -i -E "s|(^DB_URL=jdbc:mysql://)${SRC_HOST}|\1127.0.0.1|" "$f"
  echo "  $f → $(grep -E '^DB_URL=' "$f" | sed -E 's|(://[^/]+).*|\1...|')  (백업 $f.bak-$TS)"
done

echo "### 4) Tomcat 기동 ###"
systemctl start tomcat9
echo "기동 대기..."; sleep 25

echo "### 5) 헬스체크 (4개 컨텍스트) ###"
ok=1
for ctx in GalleryStaff gallery GalleryTalk Manager; do
  code=$(curl -s -o /dev/null -w '%{http_code}' -L "http://127.0.0.1:8080/$ctx/" || echo 000)
  echo "  /$ctx → http=$code"
  case "$code" in 200|302|301) ;; *) ok=0 ;; esac
done
echo "### 6) DB 접속 확인(앱 로그에 SQL 오류 없는지) ###"
tail -n 30 /var/log/tomcat9/catalina.out 2>/dev/null | grep -iE "exception|error|sqlexception|communications link" | tail -10 || echo "(에러 로그 없음)"

if [ "$ok" = 1 ]; then
  echo "### ✅ 컷오버 성공. 다운타임 종료. cafe24 DB 는 폴백으로 유지(안정화 후 해지). ###"
  echo "롤백 필요시: 각 .env 의 *.bak-$TS 복원 후 systemctl restart tomcat9"
else
  echo "### ❌ 헬스체크 실패 → 자동 롤백 ###"; rollback; exit 1
fi
