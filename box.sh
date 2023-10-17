#!/bin/bash

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
    echo "正在更新脚本..."
    wget -O "$0" "https://raw.githubusercontent.com/zerowx6688/box/main/box.sh" --no-check-certificate -T 30 -t 5 -d
    echo "更新完成"
}

# 主菜单函数
function start_menu() {
    while true; do
        clear
        echo "请选择操作:"
        echo "0. 更新脚本"
        echo "1. 执行SWAP一键安装/卸载脚本"
        echo "999. 退出"

        read choice
        case $choice in
            0)
                update
                echo "按 Enter 键返回主菜单"
                read -p ""
                ;;
            1)
                swap
                echo "按 Enter 键返回主菜单"
                read -p ""
                ;;
            999)
                echo "退出脚本"
                exit 0
                ;;
            *)
                echo "无效的选项"
                ;;
        esac
    done
}

# 调用主菜单函数
start_menu
