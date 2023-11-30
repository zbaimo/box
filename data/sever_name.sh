#!/bin/bash

# 交互式输入IP地址和自定义服务器名
read -p "请输入IP地址: " ip_address
read -p "请输入自定义的服务器名: " custom_server_name
read -p "请输入主机名: " host_name

# 查找并删除已存在的相同注释段
sudo sed -i '/# Adding IP address and custom server name/,/# End of IP and server names/d' /etc/hosts

# 添加新的注释和对应的 IP 地址以及自定义服务器名
sudo tee -a /etc/hosts > /dev/null <<EOT
# Adding IP address and custom server name
$ip_address    $custom_server_name   $host_name
# End of IP and server names
EOT

# 修改主机名
echo "$host_name" | sudo tee /etc/hostname > /dev/null

# 应用新主机名
sudo hostname -F /etc/hostname > /dev/null

# 打印当前主机名
hostname > /dev/null

# 打印完全限定域名
hostname -f > /dev/null
