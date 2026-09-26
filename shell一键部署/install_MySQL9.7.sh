#!/bin/bash
echo "hello world!"
echo "现在开始安装MySQL9.7"
echo "添加官方源"
dnf -y install https://dev.mysql.com/get/mysql97-community-release-el10-1.noarch.rpm
echo "开始安装MySQL服务"
dnf -y install mysql-community-server --setopt=install_weak_deps=False
echo "启动MySQL服务"
systemctl start mysqld
echo "设置服务自启动"
systemctl enable mysqld
echo "当前服务状态"
systemctl status mysqld
echo "获取临时密码"
cat /var/log/mysqld.log | grep "password"
echo "开始截取"
temp_password=$(grep 'temporary password' /var/log/mysqld.log | awk -F " " '{print $NF}')
echo "临时密码为：${temp_password}"
echo "修改密码为：Zzj20050521@"
mysql -u root --password="$temp_password" --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Zzj20050521@';"
