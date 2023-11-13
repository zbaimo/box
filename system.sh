#!/bin/bash

while true; do
    # 打印一级菜单
    echo "请选择要安装的系统:"
    echo "1. Debian"
    echo "2. Ubuntu"
    echo "0. 退出脚本"
    read -p "请输入选项 (0, 1 或 2): " choice

    case $choice in
        0)
            echo "退出脚本"
            exit 0
            ;;
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
                    0)
                        break
                        ;;
                    1)
                        # 提示用户输入密码和端口
                        read -p "请输入密码: " PASSWORD
                        read -p "请输入端口: " PORT

                        # 执行 Debian 12 的安装命令
                        bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 12 -v 64 -p "$PASSWORD" -port $PORT                       
                        break 2  # 退出两层循环
                        ;;
                    2)
                        # 提示用户输入密码和端口
                        read -p "请输入密码: " PASSWORD
                        read -p "请输入端口: " PORT

                        # 执行 Debian 11 的安装命令
                        bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 11 -v 64 -p "$PASSWORD" -port $PORT
                        break 2  # 退出两层循环
                        ;;
                    3)
                        # 提示用户输入密码和端口
                        read -p "请输入密码: " PASSWORD
                        read -p "请输入端口: " PORT

                        # 执行 Debian 10 的安装命令
                        bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 10 -v 64 -p "$PASSWORD" -port $PORT
                        break 2  # 退出两层循环
                        ;;
                    *)
                        echo "无效的选项，请重新输入."
                        ;;
                esac
            done
            ;;
        2)
            DISTRO="ubuntu"
            break
            ;;
        *)
            echo "无效的选项，请重新输入."
            ;;
    esac
done
