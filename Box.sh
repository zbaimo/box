#!/bin/bash

#SWAP一键安装/卸载脚本
function swapsh(){
    wget -O "/root/swap.sh" "https://raw.githubusercontent.com/zerowx6688/box/blob/main/swap.sh" --no-check-certificate -T 30 -t 5 -d
    chmod +x "/root/swap.sh"
    chmod 777 "/root/swap.sh"
    echo "下载完成"
    echo "你也可以输入 bash /root/swap.sh 来手动运行"
    bash "/root/swap.sh"
}

# 主菜单
echo "请选择操作:"
echo "1. 执行SWAP一键安装/卸载脚本"
echo "2. 退出"

read choice
case $choice in
    1)
        swapsh
        ;;
    2)
        echo "退出脚本"
        ;;
    *)
        echo "无效的选项"
        ;;
esac
