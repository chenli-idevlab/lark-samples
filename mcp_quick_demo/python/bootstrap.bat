@echo off

REM 检查 Python 是否已安装 / Check if Python is installed
where uv >nul 2>nul
IF ERRORLEVEL 1 (
    echo uv 未安装，开始安装 uv... / uv not installed, starting uv installation...
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    IF ERRORLEVEL 1 (
        echo uv 安装失败，请检查问题。 / uv installation failed, please check the issue.
        pause
        EXIT /b 1
    )
) ELSE (
    for /f "tokens=*" %%i in ('uv --version') do set uv_version=%%i
    echo uv 已安装，版本:!uv_version! / uv is already installed, version: !uv_version!
)
    


REM 安装项目依赖 / Install project dependencies
IF EXIST "pyproject.toml" (
    echo 开始安装项目依赖... / Installing project dependencies...
    uv sync
    IF ERRORLEVEL 1 (
        echo 依赖安装失败，请手动检查问题。 / Dependency installation failed, please check manually.
        pause
        EXIT /b 1
    )
) ELSE (
    echo 未检测到 pyproject.toml 文件，跳过依赖安装。 / No pyproject.toml file detected, skipping dependency installation.
)
    

REM 启动项目 / Start the project
echo 启动项目... / Starting the project...
uv run src/langchain-demo.py
