@echo off

set GOPROXY=https://mirrors.aliyun.com/goproxy/ 
set GO111MODULE=on

REM ��� Go �Ƿ��Ѱ�װ / Check if Go is installed

where go >nul 2>nul
IF ERRORLEVEL 1 (
    echo ��ǰ�豸δ��װGo���Ի���, �밲װ�����ԡ�/ The current device is not installed with Go language environment, please install it and try again.
    echo �ɲο� ./go-setup.md ��װGo���Ի�����/ Refer to./go-setup.md for Go installation instructions.
    pause
    EXIT /b 1
) ELSE (
    echo Go �Ѱ�װ���汾:  / Go is already installed, version: 
    call go version
)

REM ��װ��Ŀ���� / Install project dependencies
IF EXIST "go.mod" (
    echo ��ʼ��װ��Ŀ����... / Installing project dependencies...
    call go mod tidy
) ELSE (
    echo δ�ҵ� go.mod �ļ�������������װ��/ No go.mod file found, skipping dependency installation.
    pause
    EXIT /b 1
)

echo ������Ŀ... / Starting the project...
go run .

