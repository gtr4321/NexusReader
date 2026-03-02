@echo off
chcp 65001 >nul
echo ==========================================
echo       NexusReader 1.1.0 Build Script
echo ==========================================
echo.

REM --- 1. Backend Build ---
echo [1/4] Building Backend (Python)...
cd core
if not exist ".venv" (
    echo Error: .venv not found in core/
    pause
    exit /b
)
call .venv\Scripts\activate
pip install pyinstaller websockets python-multipart uvicorn[standard]
cd ..

echo    - Running PyInstaller...
pyinstaller --clean --noconfirm --onefile --console --name "nexusreader-backend" --add-data "core;core" --hidden-import "uvicorn.logging" --hidden-import "uvicorn.loops" --hidden-import "uvicorn.loops.auto" --hidden-import "uvicorn.protocols" --hidden-import "uvicorn.protocols.http" --hidden-import "uvicorn.protocols.http.auto" --hidden-import "uvicorn.lifespan" --hidden-import "uvicorn.lifespan.on" --hidden-import "engineio.async_drivers.asgi" --hidden-import "websockets" --hidden-import "python-multipart" build_entry.py

echo    - Moving Backend Artifact...
if not exist "release\backend" mkdir "release\backend"
copy /Y "dist\nexusreader-backend.exe" "release\backend\"
if exist "core\nexusreader.db" copy /Y "core\nexusreader.db" "release\backend\"

REM --- 2. Frontend Build ---
echo [2/4] Building Frontend Renderer (Next.js)...
cd renderer
call npm run build
if %errorlevel% neq 0 (
    echo Error: Next.js build failed
    pause
    exit /b %errorlevel%
)
cd ..

echo [3/4] Packaging Frontend (Electron)...
call npm run build:electron
if %errorlevel% neq 0 (
    echo Error: Electron build failed
    pause
    exit /b %errorlevel%
)

echo [4/4] Moving Frontend Artifact...
if not exist "release\frontend" mkdir "release\frontend"
xcopy /E /I /Y "dist_electron\win-unpacked" "release\frontend\"

echo.
echo Build Complete! Files are in "release"
pause
