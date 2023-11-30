#!/bin/bash

# 颜色设置
Green="\033[32m"
Font="\033[0m"
Red="\033[31m"

# 检查是否有root权限
root_need() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${Red}错误：此脚本需要root权限才能运行！${Font}"
        exit 1
    fi
}

# 检查是否为OpenVZ
ovz_no() {
    if [[ -d "/proc/vz" ]]; then
        echo -e "${Red}您的VPS基于OpenVZ，不支持此操作！${Font}"
        exit 1
    fi
}

# 添加Swap分区
add_swap() {
    echo -e "${Green}请输入需要添加的Swap大小，建议为内存的2倍！${Font}"
    read -p "请输入Swap大小（单位：MB）:" swapsize

    # 检查是否存在swapfile
    grep -q "swapfile" /etc/fstab

    # 如果不存在，创建swap
    if [ $? -ne 0 ]; then
        echo -e "${Green}未找到swapfile，正在为其创建swapfile...${Font}"
        fallocate -l ${swapsize}M /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap defaults 0 0' >> /etc/fstab
        echo -e "${Green}Swap创建成功，并查看信息：${Font}"
        cat /proc/swaps
        cat /proc/meminfo | grep Swap
    else
        echo -e "${Red}swapfile已存在，Swap设置失败。请先运行脚本删除Swap后重新设置！${Font}"
    fi
}

# 删除Swap分区
del_swap() {
    # 检查是否存在swapfile
    grep -q "swapfile" /etc/fstab

    # 如果存在，删除Swap
    if [ $? -eq 0 ]; then
        echo -e "${Green}swapfile已找到，正在删除...${Font}"
        sed -i '/swapfile/d' /etc/fstab
        echo "3" > /proc/sys/vm/drop_caches
        swapoff -a
        rm -f /swapfile
        echo -e "${Green}Swap已删除！${Font}"
    else
        echo -e "${Red}未找到swapfile，删除Swap失败！${Font}"
    fi
}

# 主菜单
main() {
    root_need
    ovz_no
    clear
    echo -e "——————————————————————————————————————————"
    echo -e "${Green}注意: 这个脚本必须在用户为root下进行${Font}"
    echo -e "——————————————————————————————————————————"
    echo -e "${Green}Linux VPS一键添加/删除Swap脚本${Font}"
    echo -e "${Green}1、添加Swap${Font}"
    echo -e "${Green}2、删除Swap${Font}"
    echo -e "——————————————————————————————————————————"
    read -p "请输入数字 [1-2]:" num
    case "$num" in
        1)
        add_swap
        ;;
        2)
        del_swap
        ;;
        *)
        clear
        echo -e "${Green}请输入正确的数字 [1-2]${Font}"
        main
        ;;
    esac
}

main
