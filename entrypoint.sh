#!/bin/bash

# 检查挂载目录中是否有requirements.txt并安装
if [ -f "/workspace/requirements.txt" ]; then
    echo "发现 requirements.txt，正在安装Python依赖..."
    pip3 install --no-cache-dir -r /workspace/requirements.txt
fi

# 执行传入的命令或启动默认shell
if [ $# -eq 0 ]; then
    exec /bin/bash
else
    exec "$@"
fi