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
echo "提取1，2，3列"
cut cut1.txt -d " " -f 1,2,3
echo "提取3-5列"
cut cut1.txt -d " " -f 3-5
echo "提取第3列之后"
cut cut1.txt -d " " -f 3-
echo "提取第3列之前"
cut cut1.txt -d " " -f -3
