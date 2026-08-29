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
# $ 表示最后一行
# g 全局替换

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

echo "在末尾插入hello"
sed -i '$ahello' sed1.txt
# 注意此处不能用双引号
see

echo "删除刚添加的hello"
sed -i "/hello/d" sed1.txt
see

# 按规则删除
echo "删除奇数行:"
# 从第一行开始，步长2
sed "1~2d" sed1.txt

echo "删除1-3行:"
sed "1,3d" sed1.txt

echo "取反删除1-3行:"
sed "1,3!d" sed1.txt

echo "删除匹配NO.2到最后一行:"
sed '/NO.2/,$d' sed1.txt

echo "删除匹NO.2以及后一行:"
sed "/NO.2/,+1d" sed1.txt
see

# 修改
echo "修改文件第一行为hello:"
sed "1chello" sed1.txt

echo "将含有NO.3的行修改为hello:"
sed "/NO.3/chello" sed1.txt

echo "把END替换为hello:"
sed "s/END/hello/" sed1.txt
# 只会替换每行第一个匹配的，如果要替换第二个:s/END/hello/2，其他同理

echo "把修改写入文件sedlog.txt:"
sed "s/END/hello/w sedlog.txt" sed1.txt

echo "只显示修改的内容:"
sed -n "s/END/hello/p" sed1.txt

see

echo "正则表达式替换NO.后的内容为666"
sed "/NO./s/这.*/666/" sed1.txt

echo "每行末尾拼接zzj:"
sed "s/$/& zzj/" sed1.txt

echo "每行行首拼接#:"
sed "s/^/& #/" sed1.txt
see

#查
echo "查询NO.1:"
sed -n  "/NO.1/p" sed1.txt

echo "管道过滤查询进程sshd"
echo "---------------------------------------------"
echo "grep:"
ps -aux | grep "sshd"
echo "---------------------------------------------"
echo "sed:"
ps -aux | sed -n "/sshd/p"
echo "---------------------------------------------"
echo "多sed命令执行:"
echo "删除第一行，并将END改为zzj:"
sed "1d;s/NO./zzj/g" sed1.txt
# 方法二: sed -e "1d" -e "s/NO./zzj/g" sed1.txt
echo "---------------------------------------------"
# 暂存空间
# h 将模式空间覆盖复制到暂存空间
# H 将模式空间追加复制到暂存空间
# g 将暂存空间覆盖复制到模式空间
# G 将暂存空间追加复制到模式空间
# x 交换两个空间的内容

cat sed1.txt
echo "模式空间第一行复制到暂存空间，在复制回模式空间"
sed '1h;$G' sed1.txt
echo "---------------------------------------------"
echo "第一行放到暂存空间再删除,从暂存空间追加到最后一行"
sed '1{h;d};$G' sed1.txt

#
