#!/bin/bash
# awk 用于数据分析
# awk '匹配模式{动作}' {文件名}
# -F 指定输入文件拆分分隔符
# -v 赋值一个用户定义变量

# ARGC 命令行参数个数
# ARGV 命令行参数排列
# ENVIRON 支持队列中系统环境变量的使用
# FILENAME awk浏览的文件名
# FNR 浏览文件的记录数
# FS 设置输入域分隔符，等价于命令行-F选项
# NF 浏览记录的域的个数，根据分隔符分割后的列数
# NR 已读的记录数，也是行号
# OFS 输出域分隔符
# ORS 输出记录分隔符
# RS 控制记录分隔符
# $n $0变量是整条记录，$1表示当前行的第一个域......
# $NF $NF是number finally,表示最后一列的信息,跟变量NF是有区别的,变量NF统计的是每行列的总数

echo "默认每行空格分割数据"
echo "abc 123 456" | awk '{print $1 $2 $3}'

echo "搜索passwd文件有root关键字的所有行"
awk '/root/{print $0}' passwd
echo "---------------------------------------------"
echo "搜索passwd文件有root关键字的所有行，以:拆分并打印输出第七列"
awk -F ":" '/root/{print $7}' passwd
echo "---------------------------------------------"
echo "统计passwd文件的文件名，行号，列数，完整内容"
awk -F ":" '{print "文件名:"FILENAME",行号: "NR",列数: "NF",完整内容: "$0}' passwd
# 也可以用printf("文件名: %s, 行号: %s, 列数: %s, 完整内容: %s\n", FILENAME, NR, NF, $0)
echo "---------------------------------------------"
echo "打印第二行信息:"
awk -F ":" 'NR==2{printf("文件名:%s, 行号:%s, 列数:%s, 内容:%s\n", FILENAME, NR, NF, $0)}' passwd
#    "---------------------------------------------"
echo "查找以r开头的资源"
awk '/^r/' passwd
#    "---------------------------------------------"
echo "打印第一列"
awk -F ":" '{printf("第一列%s\n", $1)}' passwd
echo "---------------------------------------------"
echo "打印最后一列"
awk -F ":" '{printf("最后一列%s\n", $NF)}' passwd
echo "---------------------------------------------"
echo "打印指定范围1-5行的第1列"
awk -F ":" '{if(NR>=1 && NR<=5){print $1}}' passwd
echo "---------------------------------------------"
echo "多分隔符使用"
echo "abc/123:456" | awk -F "[/:]" '{printf("%s %s %s\n", $1, $2, $3)}'
echo "---------------------------------------------"
echo "添加开始和结束内容"
echo "abc 123 456" | awk 'BEGIN{printf("开始\n")}{printf("%s %s %s\n", $1, $2, $3)}END{printf("结束\n")}'
echo "---------------------------------------------"
echo "循环拼接字符串"
echo "abc 123 456 789" | awk -v str="" '{for(i=1; i <= NF; i++){str=str$i}}END{printf("%s\n", str)}'
echo "---------------------------------------------"
echo "数学运算"
echo "5.0" | awk -v a=1 '{printf("a=%f, a+5=%f, a-5=%f, a*5=%f, a/5=%f\n", a, a+$0, a-$0, a*$0, a/$0)}'
echo "---------------------------------------------"
echo "切割ip"
ifconfig | awk 'NR==2{printf("%s\n", $2)}'
# 或者 ifconfig | awk '/broadcast/{print $0}' | awk '{print $2}' 也可以
echo "---------------------------------------------"
echo "打印空行的行号"
sed 'G' sed1.txt
sed 'G' sed1.txt | awk '/^$/{print NR}'



#
