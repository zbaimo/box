#!/bin/bash

# 提示用户输入新的SSH端口号
read -p "请输入新的SSH端口号: " new_port

# 取消注释并修改SSH配置文件中的端口号
sudo sed -i "s/#\?Port [0-9]*/Port $new_port/" /etc/ssh/sshd_config

# 重新启动SSH服务
sudo service sshd restart

echo "SSH端口已更改为$new_port。请确保相应地更新防火墙设置。"
