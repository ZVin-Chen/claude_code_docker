FROM ubuntu:22.04

# 设置非交互模式和时区
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# 安装Node.js
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
RUN mkdir -p /workspace
WORKDIR /workspace

# 全局安装 claude-code
RUN npm install -g @anthropic-ai/claude-code

