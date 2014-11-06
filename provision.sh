echo "Build clean database"
sudo mkdir /data/
sudo mkdir /data/db/
sudo mongod --fork --logpath /var/log/mongodb.log
mongorestore /home/vagrant/app/data/buildClean1 --db build
cp /home/vagrant/app/server/DEV.config.js /home/vagrant/app/server/config.js
cp /home/vagrant/app/client/DEV.config.js /home/vagrant/app/client/config.js
sudo mkdir /home/vagrant/app/logs
sudo npm install

sudo apt-get -y install vim

# put nginx in
sudo apt-get -y install nginx

echo "Writing nginx conf"

sudo cat >/etc/nginx/sites-enabled/clinch <<EOF
upstream clinch_build_server {
  server 127.0.0.1:3003;
}

server {
    listen 3000;
    server_name localhost;
    error_log  /var/log/nginx/build/nginx_error.log  warn;

  location /static/ {
    autoindex on;
    alias /home/vagrant/app/static/;
  }

  location /server/ {
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header Host \$http_host;
      proxy_set_header X-NginX-Proxy true;
      proxy_pass http://clinch_build_server/;
      proxy_redirect off;
  }

  location /sock/{
      proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_pass http://127.0.0.1:3004;
  }

  location / {
    root /home/vagrant/app/client;
    try_files \$uri /index.html;
  }
}
EOF

sudo mkdir /var/log/nginx/build/
sudo service nginx start
sudo node /home/vagrant/app/server/router.js
