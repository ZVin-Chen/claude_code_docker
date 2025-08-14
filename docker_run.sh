#!/bin/bash

# 检查参数
if [ $# -ne 2 ]; then
    echo "使用方法: $0 <容器名称> <本地目录路径>"
    echo "示例: $0 my-claude-container /path/to/your/project"
    exit 1
fi

CONTAINER_NAME=$1
LOCAL_DIR=$2

# 检查本地目录是否存在
if [ ! -d "$LOCAL_DIR" ]; then
    echo "错误: 本地目录 '$LOCAL_DIR' 不存在"
    exit 1
fi

# 运行容器，挂载Docker socket以使用宿主机Docker
docker run -it \
    --name "$CONTAINER_NAME" \
    -v "$LOCAL_DIR":/workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    claude-code-docker