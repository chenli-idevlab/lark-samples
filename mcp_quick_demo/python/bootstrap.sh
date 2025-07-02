#!/bin/bash

# 检查 uv 是否已安装 / Check if uv is installed
if ! command -v uv &>/dev/null; then
    echo "uv 未安装，开始安装 uv... / uv not installed, starting uv installation..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    if ! command -v uv &>/dev/null; then
        echo "uv 安装失败，请检查问题。/ uv installation failed, please check the issue."
        exit 1
    fi
else
    echo "uv 已安装，版本: $(uv --version) / uv is already installed, version: $(uv --version)"
fi

# 安装项目依赖 / Install project dependencies
if [ -f "pyproject.toml" ]; then
    echo "开始安装项目依赖... / Installing project dependencies..."
    uv sync
else
    echo "未找到 pyproject.toml 文件，跳过依赖安装。/ No pyproject.toml file found, skipping dependency installation."
fi

# 启动项目 / Start the project
echo "启动项目... / Starting the project..."
uv run src/langchain-demo.py

