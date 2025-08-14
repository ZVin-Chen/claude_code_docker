FROM ubuntu:22.04

# 设置非交互模式和时区
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# 安装Node.js、Python、Docker和Docker Compose
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    python3 \
    python3-pip \
    python3-venv \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce-cli docker-compose-plugin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
RUN mkdir -p /workspace
WORKDIR /workspace

# 全局安装 claude-code
RUN npm install -g @anthropic-ai/claude-code

# 复制启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 设置入口点
ENTRYPOINT ["/entrypoint.sh"]

