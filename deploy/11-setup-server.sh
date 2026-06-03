#!/usr/bin/env bash
# 서버(Ubuntu 22.04)에서 실행: systemd 서비스(jar 3종) + manager war(Tomcat) + nginx 구성.
# 비밀번호는 포함하지 않음(이미 /opt/gallery/.env, /var/lib/tomcat9/.env 에 존재).
# 포트:  manager=8080(Tomcat)  board=8081  staff=8082  talk=8083
# 컨텍스트: board=/gallery  staff=/GalleryStaff  talk=/GalleryTalk  manager=/Manager
set -euo pipefail

APP=/opt/gallery
JAVA=/usr/bin/java

mk_service () {  # $1=name $2=jar $3=port $4=context
  cat > "/etc/systemd/system/$1.service" <<EOF
[Unit]
Description=$1
After=network-online.target
Wants=network-online.target

[Service]
User=gallery
Group=gallery
WorkingDirectory=$APP
ExecStart=$JAVA -jar $APP/$2 --server.port=$3 --server.servlet.context-path=$4
SuccessExitStatus=143
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
}

echo "### systemd 유닛 생성 ###"
mk_service gallery-board gallery-board.jar 8081 /gallery
mk_service gallery-staff gallery-staff.jar 8082 /GalleryStaff
mk_service gallery-talk  gallery-talk.jar  8083 /GalleryTalk
systemctl daemon-reload

echo "### manager war → Tomcat (컨텍스트 /Manager) ###"
[ -f /var/lib/tomcat9/webapps/Manager.war ] && cp /var/lib/tomcat9/webapps/Manager.war "$APP/backup/Manager.war.bak.$(date +%s)" || true
cp "$APP/manager.war" /var/lib/tomcat9/webapps/Manager.war
chown tomcat:tomcat /var/lib/tomcat9/webapps/Manager.war

echo "### nginx 리버스 프록시 구성 ###"
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
    location /GalleryStaff/ { proxy_pass http://127.0.0.1:8082; }
    location /GalleryTalk/  { proxy_pass http://127.0.0.1:8083; }
    location /gallery/      { proxy_pass http://127.0.0.1:8081; }

    # 레거시 내비/이미지 경로 → board(/gallery) 로 매핑
    location /community/ { rewrite ^/community/(.*)$ /gallery/$1 break; proxy_pass http://127.0.0.1:8081; }
    location /media/     { rewrite ^/media/(.*)$ /gallery/media/$1 break; proxy_pass http://127.0.0.1:8081; }

    location = / { return 301 /gallery/; }
}
NGINX
ln -sf /etc/nginx/sites-available/gallery /etc/nginx/sites-enabled/gallery
rm -f /etc/nginx/sites-enabled/default
nginx -t

echo "### 서비스 기동 ###"
systemctl enable --now gallery-board gallery-staff gallery-talk
systemctl restart tomcat9
systemctl reload nginx

echo "### 상태 ###"
sleep 5
for s in gallery-board gallery-staff gallery-talk tomcat9 nginx; do
  printf "%-16s %s\n" "$s" "$(systemctl is-active $s)"
done
echo "리슨 포트:"; ss -ltnp 2>/dev/null | grep -E ':(80|8080|8081|8082|8083)\b' | awk '{print $4}'
