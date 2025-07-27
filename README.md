# Claude Code Docker 镜像

这是一个预配置了 Claude Code CLI 工具的 Docker 镜像项目。

## 项目结构

```
claude_code_docker/
├── Dockerfile          # Docker 镜像构建文件
├── entrypoint.sh       # 容器启动脚本
├── .env                # 环境变量配置文件
└── README.md           # 项目说明文档
```

## 功能特性

- 基于 Ubuntu 22.04 构建
- 预安装 Node.js 18.x 和 Python 3
- 全局安装 `@anthropic-ai/claude-code` CLI 工具
- 支持启动时自动安装挂载目录中的 Python 依赖
- 支持配置`Anthropic API`代理端点以替换模型或优化网络访问

## 配置自定义的API代理端点

项目使用 `.env` 文件来配置必要的环境变量：

- `ANTHROPIC_BASE_URL`: API 基础 URL（配置为阿里云代理端点）
- `ANTHROPIC_AUTH_TOKEN`: 认证令牌

**如果使用的是Anthropic官方的订阅，则不需要配置**

## 使用方法

### 构建镜像

```bash
docker build -t claude-code-env .
```

### 运行容器

```bash
# 使用 .env 文件中的环境变量
docker run -it --env-file .env claude-code-env

# 或者手动指定环境变量
docker run -it \
  -e ANTHROPIC_BASE_URL=https://dashscope.aliyuncs.com/api/v2/apps/claude-code-proxy \
  -e ANTHROPIC_AUTH_TOKEN=your-token-here \
  claude-code-env
```

### 挂载工作目录并自动安装依赖

容器支持在启动时自动安装 Python 依赖：

- 如果挂载目录中存在 `requirements.txt`，会自动安装
- 依赖只在容器首次启动时安装，重启容器时不会重复安装

```bash
# 将本地项目目录挂载到容器工作空间
# 容器启动时会自动检查并安装 /workspace/requirements.txt 中的依赖
docker run -it --env-file .env -v $(pwd):/workspace claude-code-env
```

## 注意事项

- 请确保 `.env` 文件中的认证令牌有效
- 容器的工作目录为 `/workspace`
- 镜像已配置为中国上海时区 (Asia/Shanghai)

## 系统要求

- Docker 环境
- 有效的 Anthropic API 认证令牌（官方或第三方都可）