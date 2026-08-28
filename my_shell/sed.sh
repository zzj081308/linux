#!/bin/bash
# sed命令
# sed [选项参数] [模式匹配/sed程序命令] [文件名]
# -e 直接在指令列模式上进行sed的动作编辑。它告诉sed将下一个参数解释为一个sed命令，只有当命令行上给出多个sed指令时才需要使用-e选项；一行命令语句可以执行多条sed命令
# -i 直接对内容进行更改，不加-i时只是预览，不会对文件做实际修改
# -f 后跟保存了sed指令的文件
# -n 取消默认输出，sed默认会输出所有文本内容，使用-n参数后只显示处理过的行
# -r 使用扩展正则表达式，默认情况sed只识别基本正则表达式*

# 命令功能
# a add新增，a的后面可以接字符串，在下一行出现
# c change更改，更改匹配行的内容
# d delete删除，删除匹配的内容
# i insert插入，向匹配行前插入内容
# p print打印，打印输出匹配的内容，通常与-n选项连用
# s substitute替换，替换匹配的内容
# = 用来打印被匹配的行的行号
# n 读取下一行，遇到n时会自动跳入下一行
# ! 取反
# {sed命令1;sed命令2} 多个命令操作同一行

see(){
	echo "查看文件:"
	cat sed1.txt
	echo "---------------------------------------------"
}

see

#按行号增
echo "在第3行后插入hello:"
sed "3ahello" sed1.txt
see

# 可见并没有保存修改，只是预览
echo "-i 再次插入:"
sed -i "3ahello" sed1.txt
see

#按行号删
echo "删除刚才的hello"
sed -i "4d" sed1.txt
see

#按行号插
echo "在第3行前插入hello:"
sed -i "3ihello" sed1.txt
see

echo "删除刚才的hello"
sed -i "3d" sed1.txt
see

#按内容
echo "在包含END的行前面插入zzj:"
sed -i "/END/izzj" sed1.txt
see

echo "删除带zzj的行"
sed -i "/zzj/d" sed1.txt
see














