#!/bin/bash

# 定义颜色样式
Green="\e[32m"
Red="\e[31m"
Default="\e[0m"

# 定义SWAP安装/卸载函数
function swap() {
    wget -O "./swap.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/swap.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./swap.sh"
    chmod 777 "./swap.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./swap.sh 来手动运行"
    bash "./swap.sh"
}

# 定义更新脚本函数
function update() {
    echo -e "${Green}正在更新脚本...${Default}"
    wget -O "./box.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/box.sh" --no-check-certificate -T 30 -t 5 -d
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
function mt() {
    # 如果未安装jq，则安装
    if ! command -v jq &>/dev/null; then
        if [ -e "/etc/redhat-release" ]; then
            sudo yum install epel-release -y -q > /dev/null || {
                echo -e "${Red}错误：安装epel-release失败。${Default}"
                exit 1
            }
            sudo yum install jq -y -q > /dev/null || {
                echo -e "${Red}错误：安装jq失败。${Default}"
                exit 1
            }
        elif [[ $(cat /etc/os-release | grep '^ID=') =~ ubuntu ]] || [[ $(cat /etc/os-release | grep '^ID=') =~ debian ]]; then
            sudo apt-get update -y > /dev/null || {
                echo -e "${Red}错误：更新软件包列表失败。${Default}"
                exit 1
            }
            sudo apt-get install jq -y > /dev/null || {
                echo -e "${Red}错误：安装jq失败。${Default}"
                exit 1
            }
        else
            echo -e "${Red}错误：不支持的系统。${Default}"
            exit 1
        fi
    fi

    jq -V > /dev/null 2>&1 || {
        echo -e "${Red}错误：未安装jq。${Default}"
        exit 1
    }

    # 下载并执行mt.sh
    wget -O "./mt.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/mt.sh" --no-check-certificate -T 30 -t 5 -d || {
        echo -e "${Red}错误：下载mt.sh失败。${Default}"
        exit 1
    }

    chmod +x "./mt.sh"
    echo -e "${Green}下载完成。${Default}"
    echo -e "${Green}你也可以手动运行 'bash ./mt.sh'。${Default}"
    bash "./mt.sh"
}

# docker和docker-compose安装
function docker() {
    wget -O "./docker.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/docker.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./docker.sh"
    chmod 777 "./docker.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./docker.sh 来手动运行"
    bash "./docker.sh"
}
# 定义NPM安装/卸载函数
function npm() {
    wget -O "./npm.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/npm.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./npm.sh"
    chmod 777 "./npm.sh"
    echo "下载完成"
    echo "你也可以输入 bash ./npm.sh 来手动运行"
    bash "./npm.sh"
}

# 定义speed安装/卸载函数
function speed() {
    wget -O "./speed.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/speed.sh" --no-check-certificate -T 30 -t 5 -d
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

# bitwarden安装
function bitwarden() {
    wget -O "./bitwarden.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/bitwarden.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./bitwarden.sh"
    chmod 777 "./bitwarden.sh"
    echo "下载完成"
    echo "你也可以输入bash ./bitwarden.sh 来手动运行"
    bash "./bitwarden.sh"
}
# system安装
function system() {
    wget -O "./system.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/system.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./system.sh"
    chmod 777 "./system.sh"
    echo "下载完成"
    echo "你也可以输入bash ./system.sh 来手动运行"
    bash "./system.sh"
}

#x-ui面板安装
function xui() {
     bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install.sh)
}

#创建用户
function creat_user() {
     wget -O "./creat_user.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/creat_user.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./creat_user.sh"
    chmod 777 "./creat_user.sh"
    echo "下载完成"
    echo "你也可以输入bash ./creat_user.sh 来手动运行"
    bash "./creat_user.sh"
}

#修改服务器名
function sever_name() {
     wget -O "./sever_name.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/sever_name.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./sever_name.sh"
    chmod 777 "./sever_name.sh"
    echo "下载完成"
    echo "你也可以输入bash ./sever_name.sh 来手动运行"
    bash "./sever_name.sh"
}

#修改端口号
function sshport() {
     wget -O "./sshport.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/sshport.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./sshport.sh"
    chmod 777 "./sshport.sh"
    echo "下载完成"
    echo "你也可以输入bash ./sshport.sh 来手动运行"
    bash "./sshport.sh"
}

#系统信息
function ip() {
     wget -O "./ip.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/data/ip.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "./ip.sh"
    chmod 777 "./ip.sh"
    echo "下载完成"
    echo "你也可以输入bash ./ip.sh 来手动运行"
    bash "./ip.sh"
}

# 主菜单函数
function start_menu() {
    while true; do
        clear
        echo -e "${Green}==================================================${Default}"
        echo -e "${Green}                Wenx一键脚本工具                   ${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -e " ${Green}1. 更新脚本${Default}"
	echo -e " ${Green}2. 系统信息${Default}"
        echo -e " ${Green}3. 工具箱${Default}"
        echo -e " ${Green}4. 清理垃圾${Default}"
        echo -e " ${Green}5. 更新系统固件${Default}"
	echo -e "${Green}==================================================${Default}"
        echo -e " ${Green}5. Docker项目${Default}"
	echo -e " ${Green}0. 退出脚本${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -n "请输入数字:"

        read choice
        case $choice in
            1)
                update
                echo -e "按 Enter 键返回主菜单"
                read -p ""
                ;;
            3)
                ip
                echo -e "按 Enter 键返回主菜单"
                read -p ""
                ;;
	    3)
                iTool_menu
                echo -e "按 Enter 键返回主菜单"
                read -p ""
                ;;
            4)
                clean
                echo -e "清理垃圾"
                read -p ""
                ;;
	    5)
                echo -e "执行 '更新系统固件'"
                apt-get update
                apt-get install -y wget vim
                echo -e "操作完成"
                read -p "按 Enter 键返回主菜单"
                ;;
            6)
                docker_menu  # Docker项目
		echo -e "按 Enter 键返回主菜单"
                read -p ""
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
function iTool_menu() {
    while true; do
        clear
        echo -e "${Green}==================================================${Default}"
        echo -e "${Green}                 工具箱                            ${Default}"
	echo -e "${Green}          工具大多数基于Debian/Ubuntu               ${Default}"
        echo -e "${Green}================================================= ${Default}"
        echo -e " ${Green}1.  执行SWAP一键安装/卸载脚本${Default}"
        echo -e " ${Green}2.  Gost安装${Default}"
        echo -e " ${Green}3.  流媒体解锁检测${Default}"
        echo -e " ${Green}4.  Speed端口测速${Default}"
        echo -e " ${Green}5.  warp安装${Default}"
        echo -e " ${Green}6.  重装系统${Default}"
	echo -e " ${Green}7.  安装XUI面板${Default}"
        echo -e " ${Green}8.  创建用户(注意：创建新用户后root用户就无法登录了）${Default}"
	echo -e " ${Green}9.  修改服务器名${Default}"
        echo -e " ${Green}10. 修改端口号${Default}"
        echo -e " ${Green}0.  返回主菜单${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -n "请输入数字:"

        read toolbox_choice
        case $toolbox_choice in
            1)
                swap
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
            2)
                gost
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
            3)
                mt
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
            4)
                speed
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
            5)
                warp
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
            6)
                system
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
            7)
                xui
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
	    8)
                creat_user
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
	    9)
                sever_name
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
                ;;
	    10)
                sshport
                echo -e "按 Enter 键返回工具箱菜单"
                read -p ""
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


# Modified 1号子菜单函数
function docker_menu() {
    while true; do
        clear
        echo -e "${Green}==================================================${Default}"
        echo -e "${Green}                Docker安装工具                   ${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -e " ${Green}1. Docker和Docke-Compose安装${Default}"
        echo -e " ${Green}2. NPM 安装${Default}"
	echo -e " ${Green}3. Bitwarden 安装${Default}"
        echo -e " ${Green}0. 返回主菜单${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -n "请输入数字:"

        read sub_choice
        case $sub_choice in
            1)
                docker
                echo "Docker和Docke-Compose安装"
                read -p "按 Enter 键返回子菜单"
                ;;
            2)
                npm
                echo "NPM 安装"
                read -p "按 Enter 键返回子菜单"
                ;;
	    3)
                bitwarden
                echo "Bitwarden 安装"
                read -p "按 Enter 键返回子菜单"
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
