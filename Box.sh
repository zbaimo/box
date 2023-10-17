#!/bin/bash

# 定义SWAP安装/卸载函数
function swapsh() {
    wget -O "/root/swap.sh" "https://raw.githubusercontent.com/zerowx6688/box/main/swap.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "/root/swap.sh"
    chmod 777 "/root/swap.sh"
    echo "下载完成"
    echo "你也可以输入 bash /root/swap.sh 来手动运行"
    bash "/root/swap.sh"
}

# 主菜单函数
function start_menu() {
    while true; do
        clear
        echo "请选择操作:"
        echo "1. 执行SWAP一键安装/卸载脚本"
        echo "999. 退出"

        read choice
        case $choice in
            1)
                swapsh
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
