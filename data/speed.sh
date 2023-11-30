#!/bin/bash

# 检查是否为root用户
if [ "$(id -u)" -ne 0 ]; then
  echo "请以root用户权限运行此脚本。"
  exit 1
fi

# 检查是否安装iperf
if ! which iperf > /dev/null; then
  echo "iperf未安装，正在尝试安装..."
  # 使用包管理工具安装iperf，例如apt或yum
  if [ -x "$(command -v apt-get)" ]; then
    apt-get update
    apt-get install -y iperf
  elif [ -x "$(command -v yum)" ]; then
    yum install -y iperf
  else
    echo "无法安装iperf，请手动安装后重新运行脚本。"
    exit 1
  fi
fi

# 检查是否安装pv
if ! which pv > /dev/null; then
  echo "pv未安装，正在尝试安装..."
  # 使用包管理工具安装pv，例如apt或yum
  if [ -x "$(command -v apt-get)" ]; then
    apt-get update
    apt-get install -y pv
  elif [ -x "$(command -v yum)" ]; then
    yum install -y pv
  else
    echo "无法安装pv，请手动安装后重新运行脚本。"
    exit 1
  fi
fi

# 提示用户输入要测试的端口
read -p "请输入要测试的端口号: " port

# 检查端口是否合法
if ! [[ "$port" =~ ^[0-9]+$ ]]; then
  echo "端口号无效。请输入一个有效的端口号。"
  exit 1
fi

# 启动iperf服务器
iperf -s -p $port &

# 添加进度条和绿色字体
{
  sleep 1
  result=$(iperf -c localhost -p $port | pv -W -b -W -i 1 -t -r | grep -oP '(\d+\.\d+\s[G|M]bits/sec)')
  echo -e "带宽: \e[32m$result\e[0m"
} 2>&1

# 杀死后台iperf服务器进程
pkill -x iperf
