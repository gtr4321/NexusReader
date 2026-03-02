#!/bin/bash

set -e  # 遇到错误立即退出

# 颜色代码
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== 开始配置 NexusReader 环境 (macOS) ===${NC}"

# 1. 清理 Windows 迁移残留
echo -e "${YELLOW}>>> 清理 Windows 迁移残留文件...${NC}"
# 删除 node_modules (因为包含平台特定的二进制文件)
if [ -d "node_modules" ]; then
    echo "   清理根目录 node_modules..."
    rm -rf node_modules
fi
if [ -d "renderer/node_modules" ]; then
    echo "   清理 renderer/node_modules..."
    rm -rf renderer/node_modules
fi
# 删除构建产物
if [ -d "dist" ]; then
    echo "   清理 dist 目录..."
    rm -rf dist
fi
if [ -d "renderer/.next" ]; then
    echo "   清理 renderer/.next 目录..."
    rm -rf renderer/.next
fi
# 删除 Python 缓存和虚拟环境
find . -type d -name "__pycache__" -exec rm -rf {} +
if [ -d "core/.venv" ]; then
    echo "   清理 Python 虚拟环境..."
    rm -rf core/.venv
fi
echo -e "${GREEN}✅ 清理完成${NC}"

# 2. 检查基础工具
echo -e "${YELLOW}>>> 检查基础工具...${NC}"

# 检查 git
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ 错误: 未找到 git。${NC}"
    echo "   请运行 'xcode-select --install' 安装 Xcode Command Line Tools。"
    exit 1
fi

# 检查 Python3
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ 错误: 未找到 python3。${NC}"
    echo "   macOS 通常自带 python3。如果没有，请安装 Homebrew 后运行 'brew install python'。"
    exit 1
fi

# 检查 Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ 错误: 未找到 Node.js。${NC}"
    echo "   这是运行前端和 Electron 必须的。"
    echo "   请访问 ${YELLOW}https://nodejs.org/${NC} 下载并安装 LTS 版本。"
    echo "   或者如果你已安装 Homebrew，运行: ${YELLOW}brew install node${NC}"
    exit 1
fi
NODE_VERSION=$(node -v)
echo -e "${GREEN}✅ Node.js 检测通过: $NODE_VERSION${NC}"

# 检查 Rust
if ! command -v cargo &> /dev/null; then
    echo -e "${YELLOW}⚠️ 警告: 未找到 Rust (cargo)。${NC}"
    echo "   Rust 组件将无法构建。建议安装 Rust 以获得完整功能。"
    echo "   安装命令: ${YELLOW}curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh${NC}"
else
    RUST_VERSION=$(cargo --version)
    echo -e "${GREEN}✅ Rust 检测通过: $RUST_VERSION${NC}"
fi

# 3. 配置 Python 后端
echo -e "${YELLOW}>>> 配置 Python 后端 (core)...${NC}"
cd core

echo "   创建新的虚拟环境..."
python3 -m venv .venv
source .venv/bin/activate

echo "   安装 Python 依赖..."
pip install --upgrade pip
if pip install -r requirements.txt; then
    echo -e "${GREEN}✅ Python 依赖安装成功${NC}"
else
    echo -e "${RED}❌ Python 依赖安装失败${NC}"
    exit 1
fi

cd ..

# 4. 配置前端和 Electron
echo -e "${YELLOW}>>> 配置前端和 Electron...${NC}"

echo "   安装根目录依赖 (npm install)..."
if npm install; then
    echo -e "${GREEN}✅ 根目录依赖安装成功${NC}"
else
    echo -e "${RED}❌ 根目录依赖安装失败${NC}"
    exit 1
fi

echo "   安装 Renderer (Next.js) 依赖..."
cd renderer
if npm install; then
    echo -e "${GREEN}✅ Renderer 依赖安装成功${NC}"
else
    echo -e "${RED}❌ Renderer 依赖安装失败${NC}"
    exit 1
fi
cd ..

echo ""
echo -e "${GREEN}=== 环境配置全部完成！ ===${NC}"
echo ""
echo "启动指南:"
echo "1. 启动后端: python3 run.py"
echo "2. 启动前端客户端: npm run dev"
