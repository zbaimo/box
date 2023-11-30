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
echo -en "${GREEN}请输入Nginx代理管理器的Web界面端口号（默认为81）:${NC} "
read custom_port

# 使用用户输入的端口号，或者默认为81
port="${custom_port:-81}"

# 提示用户输入数据库相关参数
echo -en "${GREEN}请输入数据库用户名（默认为npm）:${NC} "
read custom_db_user

echo -en "${GREEN}请输入数据库密码（默认为npm）:${NC} "
read custom_db_passwd

# 使用用户输入的值，或者使用默认值
DB_MYSQL_USER="${custom_db_user:-npm}"
DB_MYSQL_PASSWORD="${custom_db_passwd:-npm}"
MYSQL_ROOT_PASSWORD="$DB_MYSQL_PASSWORD"
MYSQL_PASSWORD="$DB_MYSQL_PASSWORD"
MYSQL_DATABASE="$DB_MYSQL_USER"
MYSQL_USER="$DB_MYSQL_USER"

# 进入root目录
cd /root

# 检查是否存在data文件夹，如果不存在则创建
if [ ! -d "data" ]; then
    mkdir data
fi

# 进入data目录
cd data

# 检查是否存在npm文件夹，如果不存在则创建
if [ ! -d "npm" ]; then
    mkdir npm
fi

# 进入npm目录
cd npm

# 创建docker-compose.yml文件
cat <<EOL > docker-compose.yml
version: '3.8'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: always
    ports:
      - '80:80'
      - '443:443'
      - '$port:81'  # 使用用户输入的端口号
    environment:
      DB_MYSQL_HOST: "db"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "$DB_MYSQL_USER"
      DB_MYSQL_PASSWORD: "$DB_MYSQL_PASSWORD"
      DB_MYSQL_NAME: "$DB_MYSQL_USER"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    depends_on:
      - db

  db:
    image: 'jc21/mariadb-aria:latest'
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: "$DB_MYSQL_PASSWORD"
      MYSQL_DATABASE: "$MYSQL_DATABASE"
      MYSQL_USER: "$DB_MYSQL_USER"
      MYSQL_PASSWORD: "$DB_MYSQL_PASSWORD"
    volumes:
      - ./mysql:/var/lib/mysql
EOL

# 定义要使用的 Docker 镜像名
IMAGE_NAME='jc21/nginx-proxy-manager:latest'

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
echo -e "${GREEN}NPM 安装已完成${NC}"

# 显示已开通的端口
echo -e "${GREEN}已开通的端口：80, 443, $port${NC}"

# 输出默认管理员帐户和密码
echo -e "${GREEN}默认管理员帐户：admin@example.com${NC}"
echo -e "${GREEN}默认管理员密码：changeme${NC}"
