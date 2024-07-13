#!/bin/bash

# 文件用于存储所有启动的进程ID
PID_FILE="/tmp/resource_hogs.pids"

# 检查是否有消耗进程正在运行
if [ -f $PID_FILE ] && [ -s $PID_FILE ]; then
    echo "当前有以下资源消耗进程在运行："
    while IFS= read -r pid; do
        if ps -p $pid > /dev/null 2>&1; then
            echo "进程ID: $pid"
        else
            # 移除已不再运行的进程ID
            sed -i "/$pid/d" $PID_FILE
        fi
    done < $PID_FILE
else
    echo "没有资源消耗进程在运行。"
fi

# 显示菜单
echo "请选择你想要的操作:"
echo "1. 消耗一个CPU核心"
echo "2. 消耗自定义大小的内存"
echo "3. 清除所有资源消耗任务"
read -p "输入选项 (1, 2 或 3): " option

# 根据用户选择执行相应的操作
case $option in
    1)
        echo "正在消耗一个CPU核心..."
        # 使用dd命令消耗一个CPU核心
        nohup dd if=/dev/zero of=/dev/null &>/dev/null &
        PID=$!
        if ps -p $PID > /dev/null 2>&1; then
            echo $PID >> $PID_FILE
            echo "CPU核心消耗任务已启动，进程ID: $PID"
        else
            echo "CPU核心消耗任务启动失败。"
        fi
        ;;
    2)
        read -p "请输入要消耗的内存大小（MB）: " memory_size
        echo "正在消耗${memory_size}MB内存..."
        # 使用tmpfs消耗指定大小的内存
        if [ -d /mnt/memory_hog ]; then
            echo "/mnt/memory_hog already exists"
        else
            mkdir /mnt/memory_hog
        fi
        mount -t tmpfs -o size=${memory_size}M tmpfs /mnt/memory_hog
        dd if=/dev/zero of=/mnt/memory_hog/block bs=1M count=${memory_size} &>/dev/null &
        PID=$!
        if ps -p $PID > /dev/null 2>&1; then
            echo $PID >> $PID_FILE
            echo "内存消耗任务已启动，进程ID: $PID"
        else
            echo "内存消耗任务启动失败。"
        fi
        ;;
    3)
        if [ -f $PID_FILE ] && [ -s $PID_FILE ]; then
            echo "正在清除所有资源消耗任务..."
            while IFS= read -r pid; do
                if ps -p $pid > /dev/null 2>&1; then
                    kill $pid
                    echo "已终止进程ID: $pid"
                else
                    echo "进程ID $pid 不存在，跳过。"
                fi
            done < $PID_FILE
            if mountpoint -q /mnt/memory_hog; then
                umount /mnt/memory_hog
                rmdir /mnt/memory_hog
                echo "内存消耗已被清除。"
            fi
            rm -f $PID_FILE
            echo "所有资源消耗任务已被终止。"
        else
            echo "没有找到资源消耗任务。"
        fi
        ;;
    *)
        echo "无效选项，请选择1, 2 或 3."
        ;;
esac

# 提示用户进程已经在后台运行
if [[ $option -eq 1 || $option -eq 2 ]]; then
    echo "资源消耗任务已在后台运行。"
    # 显示当前后台运行的进程列表
    echo "当前运行的后台进程："
    jobs -l
fi
