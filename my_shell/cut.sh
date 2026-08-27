#!/bin/bash
# cut命令
# cut [options] filename
# -f 提取范围 列号，获取第几列
# -d 自定义分隔符 默认为制表符
# -c 提取范围 以字符为单位进行分割
# -b 以字节为单位进行分割，这些字节位置将忽略多字节字符边界，除非也指定了-n标志
# -n 与-b连用，不分割多字节字符

# 按空格分割 取第一列
# 注意文本我故意放了两个空格，所以第二个空格成为第二列
echo "查看cut1.txt:"
cat cut1.txt
echo -------------------------------------------------------
# 按列以符号分割提取
echo "提取1，2，3列"
cut cut1.txt -d " " -f 1,2,3
echo "提取3-5列"
cut cut1.txt -d " " -f 3-5
echo "提取第3列之后"
cut cut1.txt -d " " -f 3-
echo "提取第3列之前"
cut cut1.txt -d " " -f -3
echo -------------------------------------------------------
# 按符号提取
echo "提取前5个字符"
cut cut1.txt -c -5
echo "提取后3个字符"
cut cut1.txt -c 3-
echo "提取2-6个字符"
cut cut1.txt -c 2-6
echo -------------------------------------------------------
# 按字节提取
echo "提取1-7字节"
cut cut1.txt -b 1-7 
# 可见出现乱码，中文占3个字节
echo "修复乱码:"
cut cut1.txt -nb 1-7
echo "提取HMH:"
cat cut1.txt | grep "HMH" | cut -d " " -f 3
echo -------------------------------------------------------
echo "显示进程pid"
# 所有信息筛选出"bash",查看前1行,按空格分割第9列
ps -aux | grep "bash" | head -n 1 | cut -d " " -f 9
echo "提取当前ip"
# ifconfig信息取第2行,按空格分割第10列
ifconfig | sed -n "2p" | cut -d " " -f 10






#
