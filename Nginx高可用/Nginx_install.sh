#!/bin/bash
echo "开始安装Nginx"
echo "安装yum-utils组件"
yum -y install yum-utils
echo "写入repo仓库配置"
cat > /etc/yum.repos.d/nginx.repo << 'EOF'
[nginx-stable]
name=nginx stable repo
baseurl=https://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=https://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOF
echo "开始安装Nginx"
yum install -y nginx
systemctl start nginx
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --reload