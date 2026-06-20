# DB 서버 이전 설계 (cafe24 외부 MariaDB → 본 서버 로컬 MariaDB 10.6)

작성일: 2026-06-20
대상 저장소: gallery-glasses (운영: jaguar.s4g.kr)

## 1. 목표

cafe24 외부 호스팅 DB(`1.234.82.56`, MariaDB 10.1.21)의 `gallery_op` 데이터베이스를
본 서버(`210.114.18.75`, jaguar.s4g.kr)의 **로컬 MariaDB 10.6**으로 이전하고,
4개 Spring 모듈(board/staff/talk/manager)을 로컬 DB로 전환한다.

기대 효과: cafe24 외부 DB 의존/외부접속 IP 제약 제거, 단일 서버 통합, 통제권 확보, 네트워크 지연 감소.

## 2. 현재 상태 (확정 사실)

- **소스 DB**: MariaDB 10.1.21 @ `1.234.82.56:3306`, DB `gallery_op`, user `gallery_was`.
  cafe24 호스팅, 외부접속 IP 화이트리스트(본 서버 IP 허용됨). DB_URL charset=utf8.
- **타깃("본 서버")**: `210.114.18.75`(jaguar.s4g.kr / unomic007.cafe24.com), Ubuntu 22.04.
  현재 로컬 DB 미설치. Tomcat9(`/var/lib/tomcat9`)에 4개 war 단일 인스턴스(8080).
- **앱 연결**: 4개 모듈 모두 MySQL 커넥터(`com.mysql.cj.jdbc.Driver`)로 `${env.DB_URL}` 사용.
  시크릿: `/var/lib/tomcat9/.env`, `/opt/gallery/.env` (spring-dotenv).
  → **`.env`의 DB_URL/USERNAME/PASSWORD만 바꾸면 접속 대상이 전환**된다.

## 3. 결정 사항

| 항목 | 결정 | 근거 |
|---|---|---|
| 타깃 엔진/버전 | **MariaDB 10.6** (Ubuntu 22.04 기본) | 소스 10.1과 dump/restore 호환, 보안패치 지원 |
| 이전 방식 | **mysqldump 덤프 & 복원** | cafe24 공유DB라 복제/물리복사 불가 |
| 컷오버 | **점검창(maintenance window) 단일 컷오버** | 이 규모엔 짧은 다운타임이 단순·안전 |
| 기존 cafe24 DB | **읽기전용 폴백으로 당분간 보존** → 안정화 후 해지 | 즉시 롤백 가능 |
| 배치 | **본 서버에 DB 동거(co-locate)** | 단일 서버 통합 목표 |

## 4. 핵심 제약: 메모리 (총 ~4GB)

현재 2.9GB + **1GB 증설 = 약 4GB**. Tomcat 단독으로 거의 포화 상태라, DB 동거를 위해
**Tomcat 힙 축소 + MariaDB 경량 구성 + swap 확대**가 필수다.

### 메모리 가계부 (목표 구성)

| 항목 | 목표 | 비고 |
|---|---|---|
| Tomcat (4 war) | ~1.8–2.2GB | `-Xmx2048m → -Xmx1536m`로 축소 |
| MariaDB | ~0.5GB | `innodb_buffer_pool_size=256M`, `performance_schema=OFF` |
| OS + nginx 등 | ~0.5GB | |
| 여유 | ~0.8–1.2GB | + swap 3–4GB(안전망) |

### 필수 튜닝

1. **Tomcat 힙 축소**: `/etc/default/tomcat9` 의 `JAVA_OPTS` `-Xmx2048m` → `-Xmx1536m`
   (필요 시 1024m). 배포·부하 시 OOM/Full GC 모니터링.
2. **MariaDB 경량**: `innodb_buffer_pool_size=256M`, `performance_schema=OFF`,
   `max_connections` 보수적, `sort_buffer_size`/`join_buffer_size` 작게,
   `bind-address=127.0.0.1`(외부 비노출), `character-set-server=utf8`(소스 일치).
3. **swap 확대**: 현재 2GB → **3–4GB**. 상시 의존 아님, 피크 흡수용.

### 조건부 재검토 (Phase 0 측정 결과에 따라)

- 실제 DB 용량이 **10GB↑로 크면** buffer pool 256M로는 캐시 적중률이 낮아 디스크 I/O 급증 →
  4GB 부족. 이 경우 **8GB 이상 증설 권고**로 회귀하고 본 설계의 메모리 섹션을 재산정한다.
- 데이터 ≤ ~2GB면 4GB + 위 튜닝으로 충분.

## 5. 단계별 계획

### Phase 0 — 사전조사·측정 (무중단, 읽기전용)
본 서버(화이트리스트된 IP)에서 소스 DB에 접속해 측정:
- DB 총 용량(`information_schema.tables` 합계), 테이블 수, 테이블별 행수
- 문자셋/콜레이션(utf8/utf8mb4), 스토리지 엔진 분포(**InnoDB/MyISAM** — MyISAM 있으면 최종 덤프 시 락 필요)
- 본 서버 디스크 여유(`df -h`): 덤프 + 복원에 **DB 용량의 약 2–3배** 공간 필요
- 현재 Tomcat 실 RSS/피크 측정 → Xmx 하한 결정
- RAM 1GB 증설 반영 확인(`free -h`), swap 확대

**산출물**: DB 용량/엔진/charset 확정 → `innodb_buffer_pool_size`, swap 크기, 메모리 가부 최종 판정.

### Phase 1 — 본 서버 MariaDB 10.6 설치·튜닝 (무중단)
```bash
apt update && apt install -y mariadb-server        # 10.6
mysql_secure_installation
```
- `/etc/mysql/mariadb.conf.d/*.cnf` 튜닝(§4): buffer pool 256M, performance_schema OFF,
  bind-address 127.0.0.1, character-set-server utf8(소스와 일치), `lower_case_table_names` 소스 정합 확인.
- DB/유저 생성:
```sql
CREATE DATABASE gallery_op CHARACTER SET utf8 COLLATE utf8_general_ci;   -- 소스 콜레이션과 일치시킬 것
CREATE USER 'gallery_was'@'localhost' IDENTIFIED BY '<로컬비밀번호>';
GRANT ALL PRIVILEGES ON gallery_op.* TO 'gallery_was'@'localhost';
FLUSH PRIVILEGES;
```
- Tomcat 힙 축소(`/etc/default/tomcat9`) 적용 + Tomcat 재시작은 **컷오버 때 함께**(중복 다운타임 회피).

### Phase 2 — 리허설 이전 (무중단, 운영 영향 없음)
운영 DB에서 일관 백업 → 로컬 복원 → 검증 (운영은 계속 가동 중):
```bash
# InnoDB 일관 스냅샷(락 없음). MyISAM 존재 시 --single-transaction 대신 점검창에서 --lock-all-tables
mysqldump -h 1.234.82.56 -u gallery_was -p \
  --single-transaction --quick --routines --triggers --events \
  --default-character-set=utf8 --hex-blob \
  --databases gallery_op > /opt/gallery/migrate/gallery_op_rehearsal.sql

mysql -u root gallery_op < /opt/gallery/migrate/gallery_op_rehearsal.sql
```
- **검증**: 테이블 수, 테이블별 행수 비교, 주요 테이블 `CHECKSUM TABLE`, 한글 표본 확인(mojibake 점검).
- 앱을 임시로 로컬 DB에 붙여 **스모크 테스트**(로그인·고객검색·매출조회). 문자셋/엔진/콜레이션 이슈를 여기서 사전 제거.

### Phase 3 — 컷오버 (점검창, 짧은 다운타임)
순서가 메모리 경합을 피한다(Tomcat 정지 시 ~2.5GB 해제 → 복원 여유).
1. 점검 공지 → `systemctl stop tomcat9` (쓰기 차단)
2. 운영 DB **최종 덤프**(위 명령) → 로컬 `gallery_op`에 복원(기존 리허설 데이터 drop/recreate 후)
3. **검증**(행수/체크섬/표본)
4. `.env` 2곳(`/var/lib/tomcat9/.env`, `/opt/gallery/.env`) 수정:
   - `DB_URL=jdbc:mysql://localhost:3306/gallery_op?useUnicode=true&characterEncoding=utf8&...`
   - `DB_USERNAME=gallery_was`, `DB_PASSWORD=<로컬비밀번호>`
5. Tomcat 힙 축소 반영 확인 후 `systemctl start tomcat9`
6. 4개 모듈 **헬스/주요기능 점검**(로그인, 고객검색, 매출, 관리자) + `free -h`/슬로우쿼리 확인
7. 점검 종료 공지

### Phase 4 — 안정화·정리
- 며칠 모니터링: 메모리(`free -h`, mysqld RSS, swap 사용), 슬로우 쿼리, 디스크.
- **로컬 자동 백업** 구성: `mysqldump` cron(일 1회) + 외부/별도 보관 + 회전(예: 7~14일).
- 문제 없으면 cafe24 외부 DB 해지(그 전까지 읽기전용 폴백 유지).

## 6. 롤백

컷오버 중/직후 문제 발생 시:
1. `.env` 2곳의 `DB_URL/USERNAME/PASSWORD`를 **cafe24 외부 DB 값으로 원복**
2. `systemctl restart tomcat9`
→ 데이터는 컷오버 시점까지 운영 DB(cafe24)에 그대로 존재하므로 **즉시 원복**.
(컷오버 후 로컬에서 쓰기가 발생했다면 그 델타는 수동 반영 필요 → 그래서 폴백 기간 동안 이상 시 빠르게 판단.)

## 7. 리스크 & 완화

| 리스크 | 영향 | 완화 |
|---|---|---|
| 문자셋 불일치(utf8↔utf8mb4) | 한글 깨짐 | 덤프/복원/서버 charset 모두 `utf8`로 소스와 일치, 리허설에서 표본 검증 |
| MyISAM 테이블 존재 | 일관 스냅샷 불가 | Phase 0에서 엔진 점검, 있으면 최종 덤프는 점검창에서 락(`--lock-all-tables`) |
| RAM 4GB 부족(데이터 큼) | swap 폭주/OOM-kill | Phase 0 용량 측정으로 사전 판정, 크면 8GB 증설로 회귀 |
| Tomcat 힙 과소(1536m) | Full GC/OOM | 부하·배포 시 모니터링, 필요 시 상향 |
| cafe24 외부접속 제한 | 덤프 실패 | 덤프는 화이트리스트된 본 서버에서 실행 |
| 디스크 부족 | 복원 실패 | Phase 0에서 DB×2–3배 여유 확인 |

## 8. 성공 기준

- 로컬 `gallery_op` 의 테이블 수·행수·체크섬이 소스와 일치, 한글 정상.
- 4개 모듈이 로컬 DB로 정상 동작(로그인/고객검색/매출/관리자).
- 메모리 상시 사용 ≤ ~3.2GB(여유 유지), swap 상시 의존 없음.
- 로컬 자동 백업 동작 확인.
- (안정화 후) cafe24 외부 DB 해지.

## 9. Phase 0에서 확정할 미지수

- 소스 DB 실제 용량 / 테이블·행수
- 스토리지 엔진 분포(InnoDB/MyISAM)
- 문자셋·콜레이션 정확값
- 본 서버 디스크 여유, 증설 후 실제 가용 RAM
- 현재 Tomcat 실 RSS/피크 → Xmx 하한
