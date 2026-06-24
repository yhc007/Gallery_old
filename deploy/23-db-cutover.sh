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

# 헬스체크는 절대 코드(200/302)가 아니라 "컷오버 직전 cafe24 응답"과 비교한다.
# board(/gallery)·manager(/Manager)는 정상 운영 중에도 루트가 404 → baseline 대비 회귀만 실패로 본다.
CTXS=(GalleryStaff gallery GalleryTalk Manager)
declare -A BASE
echo "### 0) cafe24 baseline 헬스체크 코드 캡처 (Tomcat 정지 전) ###"
for ctx in "${CTXS[@]}"; do
  BASE[$ctx]=$(curl -s -o /dev/null -w '%{http_code}' -L --max-time 8 "http://127.0.0.1:8080/$ctx/" 2>/dev/null || echo 000)
  echo "  baseline /$ctx → http=${BASE[$ctx]}"
done

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

echo "### 5) 헬스체크 (4개 컨텍스트, cafe24 baseline 대비 회귀 판정) ###"
ok=1
for ctx in "${CTXS[@]}"; do
  code=$(curl -s -o /dev/null -w '%{http_code}' -L --max-time 10 "http://127.0.0.1:8080/$ctx/" 2>/dev/null || echo 000)
  base="${BASE[$ctx]}"; verdict="OK"
  # 실패: 응답없음(000)·서버오류(5xx) → 앱이 안 떴거나 DB장애 가능성
  if [ "$code" = "000" ] || { [ "$code" -ge 500 ] 2>/dev/null; }; then
    verdict="FAIL"; ok=0
  # 회귀: baseline 이 정상권(2xx/3xx)이었는데 지금 4xx 면 악화로 간주(404→404 는 통과)
  elif [ "$code" != "$base" ]; then
    case "$base" in 2*|3*) case "$code" in 4*) verdict="REGRESSED"; ok=0;; esac;; esac
  fi
  echo "  /$ctx → http=$code (baseline=$base) [$verdict]"
done
echo "### 6) DB 접속 확인 — 실제 SQL 오류 유무 (CglibAopProxy INFO 오탐 제외) ###"
DBERR=$(tail -n 200 /var/log/tomcat9/catalina.out 2>/dev/null \
  | grep -iE "SQLException|Communications link failure|Could not (get|open) JDBC|Cannot get a connection|Access denied for user|Unknown database|HikariPool-[0-9]+ - Exception|Connection is not available|CommunicationsException" \
  | grep -v "CglibAopProxy" | tail -10 || true)   # 무매치 grep(=정상)이 set -e/pipefail 로 조기종료되지 않게
if [ -n "$DBERR" ]; then echo "  ❌ 실DB오류 감지:"; echo "$DBERR"; ok=0; else echo "  ✅ 실DB오류 없음"; fi

if [ "$ok" = 1 ]; then
  echo "### ✅ 컷오버 성공. 다운타임 종료. cafe24 DB 는 폴백으로 유지(안정화 후 해지). ###"
  echo "롤백 필요시: 각 .env 의 *.bak-$TS 복원 후 systemctl restart tomcat9"
else
  echo "### ❌ 헬스체크 실패 → 자동 롤백 ###"; rollback; exit 1
fi
