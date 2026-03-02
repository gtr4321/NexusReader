# NexusReader 1.1.0

## 简介 / Introduction

**NexusReader** 是一个下一代智能情报分析系统，结合了高效的 RSS 阅读器和可视化的事件流画布。它旨在帮助用户从海量信息中提取关键情报，并通过直观的画布进行关联分析。

**NexusReader** is a next-generation intelligent intelligence analysis system that combines an efficient RSS reader with a visual event stream canvas. It is designed to help users extract key intelligence from massive amounts of information and perform correlation analysis through an intuitive canvas.

## 主要功能 / Key Features

- **RSS 阅读器 (RSS Reader)**: 
  - 支持添加自定义 RSS 源。
  - 实时获取和解析新闻订阅。
  - 提供分类标签管理（极客、商业、数码等）。
  - Support adding custom RSS sources.
  - Real-time fetching and parsing of news feeds.
  - Category tag management (Geek, Business, Digital, etc.).

- **事件流画布 (Event Stream Canvas)**:
  - 将新闻卡片拖拽到画布上进行自由排列。
  - 可视化连接不同事件，发现潜在关联。
  - Drag and drop news cards onto the canvas for free arrangement.
  - Visually connect different events to discover potential correlations.

- **现代化界面 (Modern UI)**:
  - 基于 Next.js 和 Tailwind CSS 构建的精美界面。
  - 支持深色模式。
  - Beautiful interface built with Next.js and Tailwind CSS.
  - Dark mode support.

## 技术栈 / Tech Stack

| Layer | Technology | Description |
|-------|------------|-------------|
| **Frontend** | Next.js 14, React, Tailwind CSS | 用户界面与交互 / User Interface & Interaction |
| **Container** | Electron | 跨平台桌面应用容器 / Cross-platform desktop container |
| **Backend** | Python (FastAPI) | 核心业务逻辑与数据处理 / Core logic & data processing |
| **Database** | SQLite | 本地数据存储 / Local data storage |

## 安装与运行 / Installation & Development

### 前置要求 / Prerequisites

- **Node.js**: v18+
- **Python**: v3.8+

### 开发环境启动 / Start Development Environment

1.  **安装依赖 / Install Dependencies**

    ```bash
    # 安装根目录依赖 (Install root dependencies)
    npm install

    # 安装前端依赖 (Install frontend dependencies)
    cd renderer && npm install && cd ..
    ```

2.  **设置 Python 环境 / Setup Python Environment**

    ```bash
    # 创建虚拟环境 (Create virtual environment)
    # Windows
    python -m venv .venv
    .venv\Scripts\activate
    
    # macOS/Linux
    # python3 -m venv .venv
    # source .venv/bin/activate

    # 安装 Python 依赖 (Install Python requirements)
    pip install -r core/requirements.txt
    ```

3.  **启动应用 / Start Application**

    ```bash
    npm run dev
    ```
    此命令将同时启动 Next.js 前端、Electron 主进程和 Python 后端。
    This command will launch the Next.js frontend, Electron main process, and Python backend simultaneously.

## 构建 / Build

打包应用程序为可执行文件：
To package the application as an executable:

```bash
npm run build
```

构建产物将位于 `release` 目录下。
The build artifacts will be located in the `release` directory.

## 许可证 / License

Private / Proprietary
