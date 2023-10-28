#!/bin/bash

# 定义颜色样式
Green="\e[32m"
Red="\e[31m"
Default="\e[0m"

# 定义SWAP安装/卸载函数
function swap() {
    wget -O "./swap.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/swap.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./swap.sh"
    chmod 777 "./swap.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./swap.sh 来手动运行"
    bash "./swap.sh"
}

# 定义更新脚本函数
function update() {
    echo -e "${Green}正在更新脚本...${Default}"
    wget -O "./box.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/box.sh" --no-check-certificate -T 30 -t 5 -d
    echo -e "${Green}更新完成${Default}"

    # 检查更新是否成功
    if [ $? -eq 0 ]; then
        echo -e "脚本已成功更新，请按 Enter 键重新打开更新后的脚本。"
        read -p ""
        bash "./box.sh"  # 重新启动已更新的脚本
        exit
    else
        echo -e "${Red}更新失败，请检查网络连接或手动下载更新。${Default}"
    fi
}

# 定义清理垃圾函数
function clean() {
    sudo apt clean
    sudo apt autoclean
    sudo apt autoremove
    sudo apt -f install
    echo -e "${Green}垃圾清理完成${Default}"
}
# 定义GOST安装函数
function gost() {
    wget --no-check-certificate -O "./gost.sh" "https://raw.githubusercontent.com/KANIKIG/Multi-EasyGost/master/gost.sh" -T 30 -t 5 -d
    chmod +x "./gost.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./gost.sh 来手动运行"
    bash "./gost.sh"
}
#MT.SH 流媒体解锁测试
function mt(){
        #安装JQ
	if [ -e "/etc/redhat-release" ];then
	yum install epel-release -y -q > /dev/null;
	yum install jq -y -q > /dev/null;
	elif [[ $(cat /etc/os-release | grep '^ID=') =~ ubuntu ]] || [[ $(cat /etc/os-release | grep '^ID=') =~ debian ]];then
	apt-get update -y > /dev/null;
	apt-get install jq > /dev/null;
	else 
	echo -e "${Font_Red}请手动安装jq${Font_Suffix}";
	exit;
	fi

        jq -V > /dev/null 2>&1;
        if [ $? -ne 0 ];then
	echo -e "${Font_Red}请手动安装jq${Font_Suffix}";
	exit;
        fi

wget -O "./mt.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/mt.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "./mt.sh"
chmod 777 "./mt.sh"
blue "下载完成"
blue "你也可以输入 bash ./mt.sh 来手动运行"
bash ./mt.sh
}
# docker和docker-compose安装
function docker() {
    wget -O "./docker.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/docker.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./docker.sh"
    chmod 777 "./docker.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./docker.sh 来手动运行"
    bash "./docker.sh"
}
# 定义NPM安装/卸载函数
function npm() {
    wget -O "./npm.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/npm.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./npm.sh"
    chmod 777 "./npm.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./npm.sh 来手动运行"
    bash "./npm.sh"
}

# 定义speed安装/卸载函数
function speed() {
    wget -O "./speed.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/speed.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./speed.sh"
    chmod 777 "./speed.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./speed.sh 来手动运行"
    bash "./speed.sh"
}
# warp安装
function warp() {
    wget -O "./warp.sh" "https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./warp.sh"
    chmod 777 "./warp.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./warp.sh 来手动运行"
    bash "./warp.sh"
}

# 主菜单函数
function start_menu() {
    while true; do
        clear
        echo -e "${Green}==================================================${Default}"
        echo -e "${Green}                Wenx一键脚本工具                   ${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -e " ${Green}1. 更新脚本${Default}"
        echo -e " ${Green}2. 执行SWAP一键安装/卸载脚本${Default}"
        echo -e " ${Green}3. 清理垃圾${Default}"
        echo -e " ${Green}4. Gost安装${Default}"
        echo -e " ${Green}5. 流媒体解锁检测${Default}"
	echo -e " ${Green}6. Speed端口测速${Default}"
        echo -e " ${Green}7. 更新系统固件${Default}"
	echo -e " ${Green}8. warp安装${Default}"
	echo -e "${Green}==================================================${Default}"
        echo -e " ${Green}8. Docker项目${Default}"
	echo -e " ${Green}0. 退出脚本${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -n "请输入数字:"

        read choice
        case $choice in
            1)
                update
                echo -e "${Green}按 Enter 键返回主菜单${Default}"
                read -p ""
                ;;
            2)
                swap
                echo -e "${Green}按 Enter 键返回主菜单${Default}"
                read -p ""
                ;;
            3)
                clean
                echo -e "${Green}清理垃圾${Default}"
                read -p ""
                ;;
            4)
                gost
                echo -e "${Green}Gost安装${Default}"
                read -p ""
                ;;
            5)
                mt
                echo -e "${Green}流媒体解锁检测${Default}"
                read -p ""
                ;;
            6)
                speed
                echo -e "${Green}Speed端口测速${Default}"
                read -p ""
                ;;
	    7)
                echo -e "${Green}执行 '更新系统固件'${Default}"
                apt-get update
                apt-get install -y wget vim
                echo -e "${Green}操作完成${Default}"
                read -p "${Green}按 Enter 键返回主菜单${Default}"
                ;;
            8)
                warp
		echo -e "${Green}执行 'warp安装'${Default}"
                echo -e "${Green}操作完成${Default}"
                read -p "${Green}按 Enter 键返回主菜单${Default}"
                ;;

	    8)
                sub_menu  # Docker项目
                ;;
            0)
                echo "退出脚本"
                exit 0
                ;;
            *)
                echo -e "无效的选项"
                ;;
        esac
    done
}

# Modified 1号子菜单函数
function sub_menu() {
    while true; do
        clear
        echo -e "${Green}==================================================${Default}"
        echo -e "${Green}                Wenx一键脚本工具                   ${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -e " ${Green}1. Docker和Docke-Compose安装${Default}"
        echo -e " ${Green}2. NPM 安装${Default}"
        echo -e " ${Green}0. 返回主菜单${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -n "请输入数字:"

        read sub_choice
        case $sub_choice in
            1)
                docker
                echo "${Green}Docker和Docke-Compose安装${Default}"
                read -p "${Green}按 Enter 键返回子菜单${Default}"
                ;;
            2)
                npm
                echo "${Green}NPM 安装${Default}"
                read -p "${Green}按 Enter 键返回子菜单${Default}"
                ;;
            0)
                return  # Return to the main menu
                ;;
            *)
                echo -e "无效的选项"
                ;;
        esac
    done
}

# 调用主菜单函数
start_menu
