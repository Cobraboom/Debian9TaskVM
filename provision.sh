#!/bin/bash


sudo echo "deb http://nginx.org/packages/debian/ stretch nginx" >> /etc/apt/sources.list
sudo echo "deb-src http://nginx.org/packages/debian/ stretch nginx" >> /etc/apt/sources.list

cd
wget http://nginx.org/keys/nginx_signing.key

sudo apt-key add nginx_signing.key

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y vim wget htop tmux

sudo apt-get install -y nginx

sudo mkdir /etc/nginx/sites-available/ /etc/nginx/sites-enabled/

cat > /etc/nginx/sites-available/DebianTaskVMNginx <<EOF
server {
    listen 80;
    server_name .DebianTaskVMNginx.loc;
    root "/home/vagrant/code";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt { access_log off; log_not_found off; }

    access_log off;
    error_log /var/log/nginx/vagrantvm-error.log error;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php5.6-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/DebianTaskVMNginx /etc/nginx/sites-enabled/DebianTaskVMNginx

sudo service nginx restart

sudo apt-get install -y apache2

sudo mkdir /var/www/debiantaskvmapach2.ru /var/www/debiantaskvmapach2.ru/public_html


cat > /var/www/debiantaskvmapach2.ru/public_html/index.html <<EOF
<html>
  <head>
	<meta charset="utf-8">
    <title>Добро пожаловать debiantaskvmapach2.ru!</title>
  </head>
  <body>
    <h1>Успех! Виртуальный хост работает!</h1>
  </body>
</html>
EOF

cat > /etc/apache2/sites-available/debiantaskvmapach2.conf <<EOF
<VirtualHost *:8888>
        ServerName debiantaskvmapach2.ru
        ServerAlias www.debiantaskvmapach2.ru
        DocumentRoot /var/www/debiantaskvmapach2.ru/public_html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo sed -i 's/80/8888/' /etc/apache2/ports.conf

sudo a2dissite 000-default.conf

sudo a2ensite debiantaskvmapach2.conf

sudo systemctl restart apache2

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

sudo systemctl restart sshd
