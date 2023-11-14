#!/bin/bash

system=""  # 初始化系统选择变量

while true; do
    # 打印一级菜单
    echo "请选择要安装的系统:"
    echo "1. Debian"
    echo "2. Ubuntu"
    echo "0. 退出脚本"
    read -p "请输入选项 (0, 1 或 2): " choice

    case $choice in
        1)
            while true; do
                # 打印二级菜单
                echo "请选择 Debian 版本:"
                echo "1. Debian 12"
                echo "2. Debian 11"
                echo "3. Debian 10"
                echo "0. 返回上级菜单"
                read -p "请输入选项 (0, 1, 2 或 3): " debian_choice

                case $debian_choice in
                    
                    1 | 2 | 3)
                        # 提示用户输入密码和端口
                        read -p "请输入密码: " PASSWORD
                        read -p "请输入端口: " PORT

                        # 设置 Debian 版本选择
                        case "$debian_choice" in
                            1)
                                system="-d 12"
                                ;;
                            2)
                                system="-d 11"
                                ;;
                            3)
                                system="-d 10"
                                ;;
                        esac
                        
                        # 检查是apt还是yum
                        if command -v apt &> /dev/null; then
                            # 如果是apt，更新并安装wget
                            apt update -y && apt install -y wget
                        elif command -v yum &> /dev/null; then
                            # 如果是yum，更新并安装wget
                            yum -y update && yum -y install wget
                        else
                            echo "未知的包管理器，无法继续安装。"
                            exit 1
                        fi
                        
                        # 执行 Debian 安装命令
                        bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') $system -v 64 -p "$PASSWORD" -port $PORT
                        break 2  # 退出两层循环
                        ;;
                    
                    0)
                        break
                        ;;

                    *)
                        echo "无效的选项，请重新输入."
                        ;;
                esac
            done
            ;;
        2)
            while true; do
                # 打印二级菜单
                echo "请选择 Ubuntu 版本:"
                echo "1. Ubuntu 22.04"
                echo "2. Ubuntu 20.04"
                echo "3. Ubuntu 18.04"
                echo "0. 返回上级菜单"
                read -p "请输入选项 (0, 22.04, 20.04 或 18.04): " ubuntu_choice

                case $ubuntu_choice in
                    
                    1 | 2 | 3)
                        # 提示用户输入密码和端口
                        read -p "请输入密码: " PASSWORD
                        read -p "请输入端口: " PORT

                        # 设置 Ubuntu 版本选择
                        case "$ubuntu_choice" in
                            1)
                                system="-u 22.04"
                                ;;
                            2)
                                system="-u 20.04"
                                ;;
                            3)
                                system="-u 18.04"
                                ;;
                        esac

                        # 检查是apt还是yum
                        if command -v apt &> /dev/null; then
                            # 如果是apt，更新并安装wget
                            apt update -y && apt install -y wget
                        elif command -v yum &> /dev/null; then
                            # 如果是yum，更新并安装wget
                            yum -y update && yum -y install wget
                        else
                            echo "未知的包管理器，无法继续安装。"
                            exit 1
                        fi

                        # 执行 Ubuntu 安装命令
                        bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') $xitong -v 64 -p "$PASSWORD" -port $PORT
                        break 2  # 退出两层循环
                        ;;
                    
                    0)
                        break
                        ;;
                    
                    *)
                        echo "无效的选项，请重新输入."
                        ;;
                esac
            done
            ;;
        0)
            echo "退出脚本"
            exit 0
            ;;
        *)
            echo "无效的选项，请重新输入."
            ;;
    esac
done
