#!/bin/bash

# ANSI颜色代码
GREEN='\e[32m'
NC='\e[0m' # 重置颜色

# 检查当前目录是否存在"data"目录
if [ -d "data" ]; then
    echo "已经存在名为 'data' 的目录，不再继续创建。"
else
    # 创建目录
    mkdir data

    # 检查是否创建成功
    if [ -d "data" ]; then
        echo "data文件夹创建成功"
    else
        echo "data文件夹创建失败"
    fi
fi

# 安装 Docker
wget -qO- get.docker.com | bash
docker_version=$(docker -v)

# 启用 Docker 自启动
systemctl enable docker

# 安装 Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
compose_version=$(docker compose version)

# 配置 Docker 守护进程
cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "20m",
        "max-file": "3"
    },
    "ipv6": true,
    "fixed-cidr-v6": "fd00:dead:beef:c0::/80",
    "experimental": true,
    "ip6tables": true
}
EOF

# 重启 Docker 守护进程
systemctl restart docker

# 不管是否创建成功，最后显示 "data" 文件夹的创建状态
if [ -d "data" ]; then
    echo -e "${GREEN}创建data文件夹成功${NC}"
else
    echo -e "${GREEN}创建data文件夹失败${NC}"
fi

# 显示 Docker 和 Docker Compose 的版本信息，绿色字体
echo -e "${GREEN}Docker 版本：$docker_version${NC}"
echo -e "${GREEN}Docker Compose 版本：$compose_version${NC}"
