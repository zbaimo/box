#!/bin/bash


# 进入root目录
cd root

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
      - '6600:81'
    environment:
      DB_MYSQL_HOST: "db"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "npm"
      DB_MYSQL_PASSWORD: "npm"
      DB_MYSQL_NAME: "npm"
    volumes:
      - ../../data:/data
      - ../../letsencrypt:/etc/letsencrypt
    depends_on:
      - db

  db:
    image: 'jc21/mariadb-aria:latest'
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: 'npm'
      MYSQL_DATABASE: 'npm'
      MYSQL_USER: 'npm'
      MYSQL_PASSWORD: 'npm'
    volumes:
      - ../../mysql:/var/lib/mysql
EOL

# 执行docker-compose up -d
cd root/data/npm
docker compose up -d

# 退出npm目录
cd ..


