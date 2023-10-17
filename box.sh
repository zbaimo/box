#!/bin/bash

# 定义颜色样式
Green="\e[32m"
Red="\e[31m"
Default="\e[0m"

# 定义SWAP安装/卸载函数
function swap() {
    wget -O "/root/swap.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/swap.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "/root/swap.sh"
    chmod 777 "/root/swap.sh"
    echo "下载完成"
    echo "你也可以输入 bash /root/swap.sh 来手动运行"
    bash "/root/swap.sh"
}

# 定义更新脚本函数
function update() {
    echo -e "${Green}正在更新脚本...${Default}"
    wget -O "$0" "https://raw.githubusercontent.com/zerowx6688/box/main/box.sh" --no-check-certificate -T 30 -t 5 -d
    echo -e "${Green}更新完成${Default}"
}

# 定义清理垃圾函数
function clean() {
    sudo apt clean
    sudo apt autoclean
    sudo apt autoremove
    sudo apt -f install
    echo -e "${Green}垃圾清理完成${Default}"
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
        echo -e " ${Green}999. 退出脚本${Default}"
        echo -e "${Green}==================================================${Default}"
        echo -e "请选择操作:"

        read choice
        case $choice in
            1)
                update
                echo -e "按 Enter 键返回主菜单"
                read -p ""
                ;;
            2)
                swap
                echo -e "按 Enter 键返回主菜单"
                read -p ""
                ;;
            3)
                clean
                echo -e "清理垃圾"
                read -p ""
                ;;
            999)
                echo "退出脚本"
                exit 0
                ;;
            *)
                echo -e "无效的选项"
                ;;
        esac
    done
}

# 调用主菜单函数
start_menu
