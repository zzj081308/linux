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

echo ----------------------------------------------------------

#一些特殊变量
echo "传递到脚本的参数总数:$#"
echo "*, 以一个字符串显示传递到脚本的所有参数"
echo "@, 等价上面(不加引号)"
echo "$, 当前脚本运行的进程id:" $$
echo "!, 后台最后一个运行的进程id:" $!
echo "?, 最后命令的退出状态:(0正常, 非零异常) $?"

#这是数组
my_array=(1 2 3 4 5)
echo "数组:${my_array[*]}"

echo "*和@都可以遍历数组"

#这是整形
typeset -i sum=0

echo ----------------------------------------------------------

#这是循环
echo "执行循环"
for i in ${my_array[*]}
do	#循环开始
	#循环体
	sum=sum+1
	echo "循环次数${sum}"
	echo "$i"
done	#循环结束

echo ----------------------------------------------------------

sum=0

echo "*加了引号后:"
for i in "$*"
do
	echo "$i"
	sum=sum+1
	echo "循环次数$sum"
done

echo ----------------------------------------------------------

sum=0

echo "@加了引号后:"
for i in "$@"
do
        echo "$i"
        sum=sum+1
        echo "循环次数$sum"
done
echo ----------------------------------------------------------
#字符串
var1=这是字符串
var2='这也是字符串'
var3="这还是字符串"
echo $var1
echo '$var2,但单引号不可解析变量'
echo "$var3"
echo "var3的字符串长度${#var3}"
echo 字符串拼接${var1}'+'"${var3}"
echo ----------------------------------------------------------
#字符串截取
var1="abcdefg"
echo "字符串截取$var1"
echo "前三个${var1:0:3}"
echo "后三个${var1:0-3:3}"
echo "中间三个${var1:2:3}"
var1="aabbbcddeeeffg"
echo "第一个b后面的${var1#*b}"
echo "最后一个b后面的${var1##*b}"
echo "最后一个e前面的${var1%e*}"
echo "第一个e前面的${var1%%e*}"
echo ----------------------------------------------------------
#数组
#按内容创建数组
array1=(1 2 3 "a" "b" "c")
echo "array1:${array1[*]}"
#按下标创建数组(甚至可以断开)
array2=([0]=4 [1]=5 [2]=6 [3]="a" [10]="abc")
echo "array2:${array2[*]}"
echo "array2长度:${#array2[*]}"
echo "array2的下标10元素长度:${#array2[10]}"
array1=(1 2 3)
array2=(a b c)
echo "${array1[*]}"
echo "${array2[*]}"
new_array=(${array1[*]} ${array2[*]})
echo "数组拼接:${new_array[*]}"
unset new_array[2]
echo "删除下标2元素3:${new_array[*]}"
unset new_array
echo "删除整个数组:${new_array[*]}"
echo ----------------------------------------------------------
#命令设置别名
#先查看命令是shell内嵌命令还是可执行文件
echo "cd命令相关信息:" `type cd`
echo "ifconfig命令相关信息:" `type ifconfig`

#但此处位于sh脚本文件内用不了alias好像
echo ----------------------------------------------------------
#echo中-e启用转义字符
echo -e "hello\nworld"
echo ----------------------------------------------------------
#输入内容
echo "输入:"
read 
#输入的内容会默认存在$REPLY
echo "输出REPLAY: ${REPLY}"
#也可以之间输入到变量中
echo "输入name:"
read name
echo "输出name:${name}"
#输入提示信息
read -p "输入提示信息:" my_input
echo ${my_input}
read -p "限制输入3个字符:" -n 3 my_input
echo -e "\n输出${my_input}"
#静默输入，输入不显示，常用于密码输入
read -p "静默输入:" -s my_input
echo "输出:${my_input}"
#设置输入时间
read -p "3秒后停止输入:" -t 3 my_input
#多变量输入
read -p "请输入姓名 年龄:(空格隔开)" name age
echo "姓名:${name} 年龄:${age}"
echo ----------------------------------------------------------
#declare 设置变量
#设置变量为整形
echo "设置var1为整形"
declare -i var1=10
echo "var1:${var1}"
echo "尝试改变var1为abc"
var1="abc"
echo "改变后:"${var1}
echo "取消var1的整形:"
declare +i var1=abc
echo "取消后:${var1}"
:<<EOF
- 添加属性
+ 取消属性

a 设置为array普通索引数组
A 设置为key-value关联数组
r 设置为readonly只读
x 设置为export环境变量
i 设置为int整形
f 设置为function函数
EOF
echo ----------------------------------------------------------
#关联数组
#其实和python字典差不多
echo "输出关联数组"
declare -A zzj=(["name"]="zzj" ["age"]=18 ["score"]=95)
echo "${zzj["name"]} ${zzj["age"]} ${zzj["score"]}"
echo ----------------------------------------------------------
#expr求值表达式
#可以返回运算的结果
echo "运算结果:" `expr 1 + 1`
#算术表达式
echo "加法1+1=" `expr 1 + 1`
echo "减法2-1=" `expr 2 - 1`
echo "乘法2*3=" `expr 2 \* 3`	#乘法*要转义
echo "除法4/2=" `expr 4 / 2`
echo "取余5%2=" `expr 5 % 2`
echo ---------------------------------------------------------
#if选择语句
a=1
if [ $a == 1 ] 
then
	echo "条件1成立"
elif [ $a == 2 ]
then
	echo "条件2成立"
else
	echo "条件1,2不成立"
fi

#相等==
#不等!=
a=10
b=20
if [ $a == $b ]
then
	echo "$a 等于 $b"
fi
if [ $a != $b ]
then
	echo "$a 不等于 $b"
fi
echo ---------------------------------------------------------
#关系运算符
a=1
b=2
c=2
echo "a=1, b=2, c=2"
if [ $a -eq $b ]
then
	echo "$a -eq $b, $a等于$b"
else
	echo "$a -eq $b, $a不等于$b"
fi

if [ $a -ne $b ]
then
	echo "$a -ne $b, $a不等于$b"
else
	echo "$a -ne $b, $a等于$b"
fi

if [ $a -gt $b ]
then
	echo "$a -gt $b, $a大于$b"
else
	echo "$a -gt $b, $a不大于$b"
fi

if [ $a -lt $b ]
then
	echo "$a -lt $b, $a小于$b"
else
	echo "$a -lt $b, $a不小于$b"
fi

if [ $a -ge $b ]
then
	echo "$a -ge $b, $a大于等于$b"
else
	echo "$a -ge $b, $a不大于等于$b"
fi

if [ $b -le $c ]
then
	echo "$b -le $c, $b小于等于$c"
else
	echo "$b -le $c, $b不小于等于$c"
fi
echo ---------------------------------------------------------
#布尔运算符
a=10
b=20
echo "a=10, b=20"

if [ $a != $b ]
then
	echo "$a != $b, 表达式成立"
else
	echo "$a != $b, 表达式不成立"
fi

if [ $a -gt 5 -o $b -gt 30  ]
then
	echo "$a大于5, $b大于30, 至少一条成立"
else
	echo "$a大于5, $b大于30, 一条都不成立"
fi

if [ $a -gt 11 -o $b -gt 21 ]
then
	echo "$a大于11, $b大于21, 至少一条成立"
else
	echo "$a大于11, $b大于21, 一条都不成立"
fi

if [ $a -gt 5 -a $b -gt 15 ]
then
	echo "$a大于5, $b大于15, 都成立"
else
	echo "$a大于5, $b大于15, 至少一条不成立"
fi

if [ $a -gt 11 -a $b -gt 15 ]
then
	echo "$a大于11, $b大于15, 都成立"
else
	echo "$a大于11, $b大于15, 至少一条不成立"
fi
echo ---------------------------------------------------------
#其实, 大于小于的比较可以用>,<,>=,<=
#但仅限于[[]]中, 否则需要转义\>,\<
#所以后续除了布尔运算需要单中括号, 其他全都使用[[]]
#[]会分割空格, "a b c"不会被识别为一个字符串，而是三个, "a" "b" "c"
#-------------------------------------------------------------------
#逻辑运算符
a=10
b=20

echo "a=10,b=20"
if [[ $a > 5 && $b > 15 ]]
then
	echo "$a > 5 && $b > 15, 全都成立"
else
	echo "$a > 5 && $b > 15, 有一条不成立"
fi

if [[ $a > 5 || $b > 30 ]]
then
	echo "$a > 5 || $b > 30, 至少一条成立"
else
	echo "$a > 5 || $b > 30, 全都不成立"
fi
#和布尔运算符差不多
echo ---------------------------------------------------------
#字符串运算符
str1="abc"
str2="defg"
str3="abc"
str4=""
echo "str1=abc, str2=defg, str3=abc, str4="
if [[ $str1 = $str2 ]]
then
	echo "str1 = str2"
elif [[ $str1 = $str3 ]]
then
	echo "str1 = str3"
fi

if [[ $str1 != $str2 ]]
then
	echo "str1 != str2"
fi

if [[ -z $str1 ]]
then
	echo "str1长度为0"
else
	echo "str1长度:${#str1}"
fi

if [[ -z $str4 ]]
then
	echo "str4长度为0"
else
	echo "str4长度:${#str4}"
fi

if [[ -n $str1 ]]
then
	echo "str1长度不为0, 长度:${#str1}"
else
	echo "str1长度为0"
fi

if [[ -n $str4 ]]
then
	echo "str4长度不为0, 长度:${#str4}"
else
	echo "str4长度为0"
fi	

if [[ $str1 ]]
then
	echo "str1不为空"
else
	echo "str1为空"
fi
echo ---------------------------------------------------------
#文件测试运算符

#-b块文件
file="/dev/sda1"
if [[ -b $file ]]
then
	echo "${file}是块文件"
fi

file="/root/my_shell"
if [[ -d $file ]]
then
	echo "$file是目录"
fi

file="/root/my_shell/test.sh"
if [[ -f $file ]]
then
	echo "$file是普通文件"
fi

if [[ -r $file ]]
then
	echo "$file可读"
else
	echo "$file不可读"
fi

if [[ -w $file ]]
then
	echo "$file可写"
else
	echo "$file不可写"
fi

if [[ -x $file ]]
then
	echo "$file可执行"
else
	echo "$file不可执行"
fi

if [[ -s $file ]]
then 
	echo "$file不为空"
else
	echo "$file为空"
fi

if [[ -e $file ]]
then
	echo "$file存在"
else
	echo "$file不存在"
fi
echo ---------------------------------------------------------
#expr
#返回运算值
echo "expr返回运算结果: `expr 1 + 2`"

#返回字符串长度
echo "expr返回字符串长度:`expr length "zzj123"`"

#截取字符串
# expr sunstr 字符串 起始位 截取长度
echo "expr截取字符串:`expr substr "zzj123" 2 4`"

#字符串查找字符
echo "expr查找字符串j位置:`expr index "zzj123" 'j' `"

#正则表达式
# expr match 字符串 正则表达式
# expr 字符串 : 正则表达式
echo "正则表达式统计1之前的字符数:`expr match "zzj123" ".*1" `"
echo ---------------------------------------------------------
#(())符号应用
#用于表达式计算和赋值,会自动解析变量,不用加$
((a=1+2))
((b=a+1))
echo "(())计算结果:a=$a , b=$b" 
a=$((1+3))
b=$((a+1))
echo "(())计算结果:a=$a , b=$b"
#连写
((a=1+5, b=a+2))
echo "连写(()): a=$a , b=$b"
#还可以写逻辑表达式
if ((a < 0))
then
	echo "a < 0"
else
	echo "a >= 0"
fi
echo ---------------------------------------------------------
#let
#和(())差不多，但仅用于赋值
let a=1+2
let b=a+1
echo "let方法输出: a=$a , b=$b"
let a=3 b=a+2
echo "连写let输出: a=$a , b=$b"
# ---------------------------------------------------------
# $[]使用
# 这个不能赋值，只能计算
a=$[1+6]
b=$[a+1]
echo "$ []输出:a=$a , b=$b"
# ---------------------------------------------------------
# bc命令

#先创建个文件
touch task.txt
#往里面写一点算式
echo -e "108*67+12345\n58+2007*11" > task.txt
echo -e "bc计算结果:"
# -q 不显示bc界面提示信息
echo "下面进入bc界面,输入quit退出"
bc -q task.txt
# quit 是退出bc, bc是交互式界面
# scale 指定保留几位小数
# ibase 指定输入进制
# obase 指定输出进制
# last 获取上一次的结果
# -l 内置标准数学库
# s()	sin()函数
# c()	cos()函数
# a()	arctan()函数
# l() 	ln()函数
# e()	e^x函数
# j(n, x)	计算从n到x的阶数
# ---------------------------------------------------------
#管道bc,可以借助管道符将bc语句传给bc计算
echo "管道计算bc,9*9="
echo "9*9" | bc
# bc里可以解析shell变量
a=10
echo "bc变量计算:"
echo "b=${a}*2;b" | bc
#这里a是外部的shell变量要加$,b是bc里的变量不需要加
#bc计算的结果也可以传给shell变量
var1=`echo "b=${a}*3;b" | bc`
echo "接收bc结果var1=$var1"
#或者$(),不推荐,兼容性不好,不是所有linux都可以用
var2=$(echo "b=${a}*4;b" | bc)
echo "接收bc结果var2=$var2"
#bc输入重定向
echo "bc输入流:"
var1=`bc << EOF
a=10+5;
b=a*3;
b
EOF
`
echo "bc输入流的var1=$var1"
echo ---------------------------------------------------------
# test命令
# 和[]差不多,可以用于执行运算符
echo "test执行1=1:`test 1 -eq 1` 返回码:$?"
# ---------------------------------------------------------
#case选择语句
read -p "请输入1-3之间的数字:" num
case $num in
	1)
		echo "你选择了1"
		;;
	2)
		echo "你选择了2"
		;;
	3)
		echo "你选择了3"
		;;
	*)
		echo "你输入了其他内容"
		;;
esac
# 括号左边可以写正则表达式
# ---------------------------------------------------------
# while循环
echo "输出1-5数字:"
i=1
while (( i <= 5 ))
do
	echo "$i"
	let "i++"
done
# 老规矩, break; continue;可以停止循环
# while : 或者 while true  是无限循环
echo ---------------------------------------------------------
# until语句
# 执行到条件成立时停止,与while相反
echo "i=10,i++,直到i=20"
i=10
until [[ $i == 20 ]]
do
	echo "$i"
	let i++
done
echo ---------------------------------------------------------
# for循环
# 按值循环
for loop in 1 2 3 4 5
do
	echo "loop=$loop"
done
# 区间写法
echo ---------------------------------------------------------
echo "区间循环"
for i in {1..20}
do
	echo $i
done
# 常规写法
echo ---------------------------------------------------------
echo "常规循环"
for ((i=0; i<=10; i++))
do
	echo "$i"
done
echo ---------------------------------------------------------
# select语句
# select 是一种交互式循环,常用于菜单选择
# 只有break和ctrl+D,ctrl+C才可以停止
echo "请输入你的选择:"
select i in 1 2 3
do
	echo "选项$i"
	echo "此处停不下来,请按ctrl+D"
done
echo ---------------------------------------------------------
# 一般配合case使用
select i in 1 2 3
do
	case $i in
		1)
			echo "选项1"
			break
			;;
		2)
			echo "选项2"
			break
			;;
		3)
			echo "选项3"
			break
			;;
		*)
			echo "输入有误"
			break
			;;
	esac
done
echo ---------------------------------------------------------
# 函数
# 系统函数, 就是系统里自带的函数, 可以直接用
# basename函数, 显示路径下文件名,可以写相对路径 
echo "basename函数:"
basename /my_shell/demo.sh
echo "basename函数(去后缀):"
basename /my_shell/demo.sh .sh

#dirname函数,显示文件的路径,不包括文件名
echo "dirname函数:"
dirname "/my_shell/demo.sh"

# 自定义函数
echo "自定义函数:"
myfun()
{
	echo "这是函数"
	echo "参数1:$1"
	echo "参数2:$2"
	ret=123
	return $ret
}

myfun "zzj1" "zzj2"
echo "输出返回值:$?"
echo ---------------------------------------------------------



#
