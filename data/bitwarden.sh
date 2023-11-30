#!/bin/bash

# 设置绿色文本颜色
GREEN='\033[0;32m'
NC='\033[0m' # 重置颜色

# 函数用于显示进度条
show_progress() {
    local duration="$1"
    local progress=0
    local block="■"
    local progress_text=""

    while [ $progress -lt 100 ]; do
        progress=$((progress + 1))
        sleep "$duration"
        block_count=$((progress / 2))
        progress_text="[$(printf "%0.s$block" $(seq 1 $block_count))$(printf "%0.s " $(seq $((block_count + 1)) 50))]"
        echo -ne "\r${GREEN}进度: $progress_text $progress%${NC}"
    done

    echo -e "\n"
}

# 提示用户输入端口号
echo -en "${GREEN}请输入Bitwarden密码管理器的Web界面端口号（默认为80）:${NC} "
read custom_port

# 使用用户输入的端口号，或者默认为80
port="${custom_port:-80}"

# 进入root目录
cd /root

# 检查是否存在data文件夹，如果不存在则创建
if [ ! -d "data" ]; then
    mkdir data
fi

# 进入data目录
cd data

# 检查是否存在npm文件夹，如果不存在则创建
if [ ! -d "bitwarden" ]; then
    mkdir bitwarden
fi

# 进入bitwarden目录
cd bitwarden

# 创建docker-compose.yml文件
cat <<EOL > docker-compose.yml
version: '3.3'
services:
    server:
        container_name: bitwardenrs
        restart: unless-stopped
        environment:
            - SIGNUPS_ALLOWED=true
            - WEBSOCKET_ENABLED=true
        volumes:
            - './data/:/data/'
        ports:
            - '$port:80'
            - '3012:3012'
        image: 'vaultwarden/server:latest'
EOL

# 定义要使用的 Docker 镜像名
IMAGE_NAME='vaultwarden/server:latest'

# 检查是否有特定镜像名的 Docker 镜像
if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "$IMAGE_NAME"; then
    # 如果有特定镜像名的镜像，不显示下载消息
    echo -e "${GREEN}本地已存在 $IMAGE_NAME 镜像，将直接启动容器.${NC}"
else
    # 如果没有特定镜像名的镜像，显示下载消息
    echo -e "${GREEN}正在拉取 $IMAGE_NAME 镜像，可能需要一些时间...${NC}"
fi

# 执行 docker-compose up -d，并隐藏输出
docker compose up -d > /dev/null 2>&1
# 显示进度条
show_progress 0.1

# 输出安装完成消息
echo -e "${GREEN}Bitwarden安装已完成${NC}"

# 显示已开通的端口
echo -e "${GREEN}已开通的端口:$port${NC}"

#注意事项通知
echo -e "${GREEN}若不允许他人注册在完成注册后回来修改docker-compose.yml文件来停止注册${NC}"
