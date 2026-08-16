# Nginx

## 官方yum源安装

进入yum仓库查看

```shell
cd /etc/yum.repos.d/
```

## 查看仓库

![](pic/Snipaste_2026-08-16_12-21-30.png)

里面还能看到我以前装的MySQL仓库

## 手动建Nginx仓库

这里先手动建一个Nginx仓库

```shell
vim nginx.repo
```

## 寻找仓库配置

然后配置去官网找

打开Nginx官网，点击“download”

![](pic/Snipaste_2026-08-16_11-51-47.png)

里面是一些安装包，划到底

![](pic/Snipaste_2026-08-16_12-34-27.png)

看不懂？翻译！

![](pic/Snipaste_2026-08-16_12-35-43.png)

是预购建软件包，点进去

![](pic/Snipaste_2026-08-16_12-37-22.png)

## 安装yum组件

原来还要安装个组件

```
sudo yum install yum-utils
```

![](pic/Snipaste_2026-08-16_12-40-05.png)

安装完成

## 把配置写入仓库

```shell
vim /etc/yum.repos.d/nginx.repo
```

![](pic/Snipaste_2026-08-16_12-42-00.png)

保存退出

## 开始安装

然后就可以之间安装了

```shell
yum install -y nginx
```

![](pic/Snipaste_2026-08-16_12-46-09.png)

安装完成

启动服务

```
systemctl start nginx
```

![](pic/Snipaste_2026-08-16_12-47-46.png)

启动成功

## 防火墙放行

防火墙放行一下80端口

```shell
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --reload
```

![](pic/Snipaste_2026-08-16_12-50-49.png)

## 验证安装

查看端口

```
netstat -anp | grep 80
```

![](pic/Snipaste_2026-08-16_12-55-57.png)

可见nginx进程监听80端口

打开浏览器输入CentOS主机ip，默认80端口

![](pic/Snipaste_2026-08-16_12-57-27.png)

Welcome to nginx!