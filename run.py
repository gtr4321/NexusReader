import uvicorn
import os
import sys

# 将当前目录添加到 sys.path 以便能找到 core 模块
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

if __name__ == "__main__":
    # 在开发模式下启用热重载
    # 生产环境通常由 Electron 启动，可能不需要 reload
    # 但作为入口脚本，默认开启 reload 方便调试
    uvicorn.run("core.main:app", host="127.0.0.1", port=8000, reload=True)
