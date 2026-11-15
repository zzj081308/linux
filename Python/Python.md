# Python

系统：CentOS Stream 10	8核4G

## 寻找版本

要安装python？打开python官网，发现没有Linux版本

根据CentOS Stream 10 的发行说明，现在有Python3.12的版本

![](pic/Snipaste_2026-10-09_20-53-17.png)

```shell
python
```

![](C:\Users\27891\Desktop\运维\安装部署文档\Python\pic\Snipaste_2026-10-09_20-56-32.png)

好的，到此为止

那来看看我的另一台设备

Ubuntu24	8核4G

![](pic/Snipaste_2026-10-09_21-01-12.png)

这下就不行了

但提示有Python的软件包

```shell
apt search python-is-python3
```

![](pic/Snipaste_2026-10-09_21-04-42.png)

还真有3.11

## 安装Python

那就装

```shell
apt install python-is-python3 -y
```

![](pic/Snipaste_2026-10-09_21-06-15.png)

## 验证

```shell
python
```

![](pic/Snipaste_2026-10-09_21-08-21.png)

就这么简单