#!/bin/bash
set -e

# 1. 检查配置文件
if [ ! -f /app/amdl/config.yaml ]; then
    echo "配置文件不存在，拷贝 config.yaml 到 /app"
    cp /backup/config.yaml /app/amdl/
    ls /app/amdl
else
    cp /app/amdl/config.yaml /app/
fi

# 2. 检查数据目录
if [ ! -d /app/rootfs/data ] || [ -z "$(ls -A /app/rootfs/data 2>/dev/null)" ]; then
    echo "/app/rootfs/data 是空的，拷贝数据目录"
    shopt -s dotglob
    cp -r /backup/rootfs/. /app/rootfs/
    ls /app/rootfs/data
else
    echo "/app/rootfs/data 不为空，跳过拷贝"
fi

# 设置语言环境
export TERM=xterm-256color
export LANG=zh_CN.UTF-8

# 启动 ttyd，使用环境变量设置认证（Basic Auth）
ttyd -W -c "${TTYD_USERNAME}:${TTYD_PASSWORD}" screen -xR mysession bash &

exit 0
