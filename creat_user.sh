#!/bin/bash

# 安装sudo
apt-get update
apt-get install -y sudo

# 获取新用户名
read -p "请输入新用户的用户名: " username

# 添加新用户
adduser $username

# 备份sudoers文件
cp /etc/sudoers /etc/sudoers.backup

# 添加新用户sudo权限
sed -i "/# User privilege specification/a $username ALL=(ALL) NOPASSWD: ALL" /etc/sudoers

# 修改SSH配置
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

# 重启SSH服务
systemctl restart sshd
