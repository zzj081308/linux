#!/bin/bash 

#这是单行注释

:<<EOF
这是多行注释
EOF

#打印输出语句
echo "hello,world"

#这是变量
var=value1
#输出变量
echo "输出变量$var"
var=value2
echo "输出变量$var"

#定义常量
readonly onlyread_var
onlyread_var=value

#删除变量
unset var
echo "删除后的var:$var"

echo "这是字符串"
echo '这也是字符串'

#接收外部变量
var1=$1	#第一个变量
var2=$2	#第二个变量
var10=${10}	#第十个变量
echo "文件名:$0, 变量1:$1, 变量2:$2, 变量10:${10}"

#一些特殊变量
echo "传递到脚本的参数总数:$#"
echo "*, 以一个字符串显示传递到脚本的所有参数"
echo "@,等价上面(不加引号)"

#这是数组
my_array=(1 2 3 4 5)
echo "数组:$my_array"

echo "*和@都可以遍历数组"

#这是整形
typeset -i sum=0

#这是循环
echo "执行循环"
for i in ${my_array[*]}
do	#循环开始
	#循环体
	sum=sum+1
	echo "循环次数${sum}"
	echo "$i"
done	#循环结束

sum=0

echo "*加了引号后:"
for i in "$*"
do
	echo "$i"
	sum=sum+1
	echo "循环次数$sum"
done

sum=0

echo "@加了引号后:"
for i in "$@"
do
        echo "$i"
        sum=sum+1
        echo "循环次数$sum"
done

