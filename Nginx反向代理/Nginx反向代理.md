# Nginx反向代理

需要达到的效果：

在外部客户端浏览器访问一个域名，由nginx反向代理到tomcat页面

## 启动Tomcat

目前已安装tomcat11.0.24，上次装过了，位于/export/server/apache-tomcat-11.0.24

创了个链接文件在root目录里

![](pic/Snipaste_2026-09-26_15-27-37.png)

进入目录运行tomcat

```shell
cd tomcat11/bin
./startup.sh
```

![](pic/Snipaste_2026-09-26_15-30-16.png)

 现在可以直接访问192.168.253.135:8080看见tomcat页面了

![](pic/Snipaste_2026-09-26_15-47-22.png)

tomcat就启动完毕

由于申请不了公共的域名，所以就在自己电脑里的dns的host加一条本地域名吧

域名就用www.zzj.com

## 添加host本地域名

打开C:\Windows\System32\drivers\etc\hosts

![](pic/Snipaste_2026-09-26_15-42-17.png)

打开后在底下加一条

```shell
192.168.253.135 www.zzj.com
```

![](pic/Snipaste_2026-09-26_15-44-14.png)

设置完这个后，现在可以通过www.zzj.com:8080进行tomcat访问

![](pic/Snipaste_2026-09-26_15-46-55.png)

但还没有达到最终效果

我们需要只访问www.zzj.com，不要端口号

现在来设置nginx反向代理

## Nginx配置反向代理

打开nginx的配置文件nginx.conf

```shell
vim /etc/nginx/nginx.conf
```

![](pic/Snipaste_2026-09-26_15-52-44.png)

打开发现server模块不见了

注意到底部写着`include /etc/nginx/conf.d/*.conf`

查看`/etc/nginx/conf.d`目录

```shell
ls /etc/nginx/conf.d
```

![](pic/Snipaste_2026-09-26_15-56-29.png)

发现里面有个`default.conf`

打开看看

```shell
vim /etc/nginx/conf.d/default.conf
```

原来server在这里

![](pic/Snipaste_2026-09-26_15-58-29.png)

现在修改配置文件

### 修改配置文件

主机改为 www.zzj.com 192.168.253.135

再在location里加一条

proxy_pass 指定为http://127.0.0.1:8080;

没用的root和index删掉

![](C:\Users\27891\Desktop\运维\安装部署文档\Nginx反向代理\pic\Snipaste_2026-09-26_16-22-33.png)

### 重载nginx

```shell
systemctl restart nginx
```

### 修改selinux

改一下selinux才可以访问（类似于防火墙）

```shell
setsebool -P httpd_can_network_connect on
```

![](pic/Snipaste_2026-09-26_16-27-42.png)