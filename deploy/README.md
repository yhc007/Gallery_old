# 배포 가이드 (cafe24 VPS/클라우드)

도메인 변경(`jaguar.s4gallery.com` → `https://jaguar.s4g.kr`) 반영을 위한 빌드·배포 스크립트입니다.
구성: **manager = Tomcat war, board/staff/talk = `java -jar`**.

## 순서

```bash
cd deploy
cp config.env.example config.env      # 1) 값 채우기 (SSH/Tomcat 경로/포트 등)
./00-discover.sh                      # 2) 서버 현황 파악 (read-only)  ← config.env 값 검증용
./01-build.sh                         # 3) 로컬 빌드 (JDK 11, 테스트 제외)
./02-deploy.sh                        # 4) 업로드 + 재시작 (덮어쓰기 전 자동 백업)
```

`config.env` 에는 접속정보가 들어가므로 git 에 올리지 마세요(이미 `.gitignore` 처리됨).

## ⚠️ 배포 전 반드시 확인 (`00-discover.sh` 결과로 대조)

1. **war 파일명** — 현재 Tomcat `webapps` 에 떠 있는 manager war 이름과
   `MANAGER_WAR_NAME` 을 **똑같이** 맞추세요.
   - `ROOT.war` → 컨텍스트 `/` , `Manager.war` → 컨텍스트 `/Manager`
   - 코드의 링크는 `/Manager/...` 를 가정합니다. 현재 서버가 `ROOT.war`(컨텍스트 `/`)로
     떠 있고 그 앞단 nginx 가 `/Manager` → 이 Tomcat 으로 프록시하는 구조일 수 있으니,
     `00-discover.sh` 의 nginx `proxy_pass` 매핑을 확인해 현재 구조를 그대로 따르세요.
2. **Tomcat 경로** (`TOMCAT_WEBAPPS`, `TOMCAT_RESTART_CMD`) — systemd 라면
   `TOMCAT_RESTART_CMD="systemctl restart tomcat"` 로 바꾸세요.
3. **jar 실행 방식** — 본 스크립트는 `pgrep` 로 기존 프로세스를 죽이고 `nohup` 으로 재기동합니다.
   현재 **systemd 서비스**로 관리 중이라면(`00-discover.sh` 에 gallery-* 서비스가 보이면)
   `02-deploy.sh` 의 jar 재기동 부분을 `systemctl restart <서비스명>` 으로 바꿔야 합니다.
4. **포트** (`BOARD_PORT/STAFF_PORT/TALK_PORT`) — 현재 운영 포트와 동일하게.
5. **HTTPS/DNS (인프라, 코드 밖)** — `https://` 로 바꿨으므로 다음이 선행되어야 정상 동작:
   - DNS: `jaguar.s4g.kr`(및 `s4g.kr`) 가 이 서버를 가리킴
   - SSL 인증서: 해당 도메인용 인증서가 nginx/Apache 에 설치됨 (없으면 https 호출 전부 실패)
   - 리버스 프록시: 443 → 각 모듈 포트/Tomcat 으로 라우팅 (`/`, `/Manager`, `/GalleryStaff`,
     `/GalleryTalk`, `/community`, `/media` 등 기존 경로 매핑 유지)

## 롤백

`02-deploy.sh` 는 덮어쓰기 전 `REMOTE_APP_DIR/backup/*.bak-<타임스탬프>` 로 백업합니다.
문제 시 해당 백업 파일을 원위치로 되돌리고 프로세스/Tomcat 을 재시작하세요.

## 참고: 코드 변경 내역
- `jaguar.s4gallery.com` → `jaguar.s4g.kr`, scheme `http` → `https` 일괄 치환 (Java + JSP 22개 파일)
- 핵심 상수: `gallery-core/.../common/CommonURI.java` 의 `DOMAIN`
