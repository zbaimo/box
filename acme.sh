#!/bin/bash

# 菜单：选择操作
echo "请选择操作："
echo "1. 申请证书"
echo "2. 删除证书"
read -p "请选择（输入1或2）: " operation

if [ "$operation" == "1" ]; then
    # 申请证书

    # 提示用户输入邮箱地址
    read -p "请输入您的邮箱地址: " email_address

    # 提示用户输入 Cloudflare API 密钥
    read -p "请输入您的 Cloudflare API 密钥: " cf_key

    # 菜单：选择证书类型
    echo "请选择证书类型："
    echo "1. 通配符域名证书"
    echo "2. 单独域名证书"
    read -p "请选择（输入1或2）: " cert_type

    # 根据用户选择提示输入域名
    read -p "请输入您的域名: " domain

    # 更新软件包列表
    apt update -y

    # 安装所需工具
    apt install -y curl socat

    # 安装 acme.sh
    curl https://get.acme.sh | sh

    # 注册帐户
    ~/.acme.sh/acme.sh --register-account -m "$email_address"
    if [ $? -ne 0 ]; then
        echo "错误：注册 acme.sh 帐户失败。"
        exit 1
    fi

    # 设置 Cloudflare API 密钥 和邮箱 作为环境变量
    export CF_Key="$cf_key"
    export CF_Email="$email_address"

    # 验证颁发 SSL 证书
    if [ "$cert_type" == "1" ]; then
        # 通配符域名证书
        ~/.acme.sh/acme.sh --issue --dns dns_cf -d "$domain" -d "*.$domain" --force
    else
        # 单独域名证书
        ~/.acme.sh/acme.sh --issue --dns dns_cf -d "$domain" --force
    fi
    if [ $? -ne 0 ]; then
        echo "错误：颁发证书失败。"
        exit 1
    fi

    # 将证书安装到 Nginx 目录
    nginx_dir="/etc/nginx"
    ~/.acme.sh/acme.sh --installcert -d "$domain" --key-file "$nginx_dir/privkey.pem" --fullchain-file "$nginx_dir/fullchain.pem"
    if [ $? -ne 0 ]; then
        echo "错误：安装证书失败。"
        exit 1
    fi

    # 升级 acme.sh 并启用自动升级
    ~/.acme.sh/acme.sh --upgrade --auto-upgrade
    if [ $? -ne 0 ]; then
        echo "错误：升级 acme.sh 失败。"
        exit 1
    fi

    # 更改 Nginx 目录的权限
    chmod -R 755 "$nginx_dir"

    # 查询和显示证书位置
    cert_key="$nginx_dir/privkey.pem"
    cert_fullchain="$nginx_dir/fullchain.pem"

    echo "证书密钥位置: $cert_key"
    echo "证书完整链位置: $cert_fullchain"

    # 完成消息
    echo "Acme 证书设置完成."

elif [ "$operation" == "2" ]; then
    # 删除证书

    # 提示用户输入域名
    read -p "请输入要删除证书的域名: " domain_to_remove

    # 删除证书
    ~/.acme.sh/acme.sh --force --remove -d "$domain_to_remove"
    if [ $? -ne 0 ]; then
        echo "错误：删除证书失败。手动输入rm -rf /root/.acme.sh/$domain"
        exit 1
    fi

    echo "证书成功删除."

else
    echo "错误：请选择1或2。"
    exit 1
fi
