#!/usr/bin/env bash
# 서버에서 실행: 4개 war 를 단일 Tomcat9 에 배포. (jar systemd 서비스는 제거)
# 컨텍스트: /gallery(board)  /GalleryStaff  /GalleryTalk  /Manager
# 비밀번호/시크릿 없음 (.env 는 이미 존재).
set -euo pipefail
APP=/opt/gallery
WEBAPPS=/var/lib/tomcat9/webapps

echo "### 1) 레거시 jar systemd 서비스 제거 ###"
for s in gallery-board gallery-staff gallery-talk; do
  systemctl disable --now "$s" 2>/dev/null || true
  rm -f "/etc/systemd/system/$s.service"
done
systemctl daemon-reload

echo "### 2) 스왑 2G 확보(OOM 방지) ###"
if ! swapon --show | grep -q '/swapfile'; then
  fallocate -l 2G /swapfile && chmod 600 /swapfile && mkswap /swapfile >/dev/null && swapon /swapfile
  grep -q '/swapfile' /etc/fstab || echo '/swapfile none swap sw 0 0' >> /etc/fstab
  echo "swap 생성됨"
else echo "swap 이미 존재"; fi

echo "### 3) Tomcat 힙 설정 ###"
sed -i '/# gallery heap override/d;/^JAVA_OPTS=.*gallery heap/d' /etc/default/tomcat9 2>/dev/null || true
if ! grep -q 'Xmx2048m' /etc/default/tomcat9; then
  echo 'JAVA_OPTS="-Djava.awt.headless=true -XX:+UseG1GC -Xms512m -Xmx2048m -XX:MaxMetaspaceSize=512m -Dfile.encoding=UTF-8" # gallery heap override' >> /etc/default/tomcat9
fi
grep 'Xmx2048m' /etc/default/tomcat9

echo "### 4) war 배포 (기존 컨텍스트 정리 후 복사) ###"
systemctl stop tomcat9
deploy_war () {  # $1=소스war $2=대상명(컨텍스트)
  local src="$APP/$1" name="$2"
  rm -rf "$WEBAPPS/${name%.war}" "$WEBAPPS/$name"
  cp "$src" "$WEBAPPS/$name"
}
deploy_war gallery.war      gallery.war       # -> /gallery
deploy_war GalleryStaff.war GalleryStaff.war  # -> /GalleryStaff
deploy_war GalleryTalk.war  GalleryTalk.war   # -> /GalleryTalk
deploy_war Manager.war      Manager.war       # -> /Manager
chown -R tomcat:tomcat "$WEBAPPS"
ls -lh "$WEBAPPS"/*.war

echo "### 5) nginx (모두 127.0.0.1:8080 단일 Tomcat) ###"
cat > /etc/nginx/sites-available/gallery <<'NGINX'
server {
    listen 80;
    listen [::]:80;
    server_name jaguar.s4g.kr s4g.kr;
    client_max_body_size 100m;

    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;

    location /Manager/      { proxy_pass http://127.0.0.1:8080; }
    location /GalleryStaff/ { proxy_pass http://127.0.0.1:8080; }
    location /GalleryTalk/  { proxy_pass http://127.0.0.1:8080; }
    location /gallery/      { proxy_pass http://127.0.0.1:8080; }

    location /community/ { rewrite ^/community/(.*)$ /gallery/$1 break; proxy_pass http://127.0.0.1:8080; }
    location /media/     { rewrite ^/media/(.*)$ /gallery/media/$1 break; proxy_pass http://127.0.0.1:8080; }

    location = / { return 301 /gallery/; }
}
NGINX
ln -sf /etc/nginx/sites-available/gallery /etc/nginx/sites-enabled/gallery
rm -f /etc/nginx/sites-enabled/default
nginx -t

echo "### 6) 기동 ###"
systemctl start tomcat9
systemctl reload nginx
echo "Tomcat 기동 중... (war 4개 전개 대기)"
