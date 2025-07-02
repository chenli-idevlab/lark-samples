@echo off

REM ��� Java �Ƿ��Ѱ�װ / Check if Java is installed
where java >nul 2>nul
IF ERRORLEVEL 1 (
    echo ��ǰ�豸δ��װJava jdk, �밲װ�����ԡ�/ Java is not installed. Please install it to continue.
    echo �ɲο� ./java_maven-setup.md ��װjava������/ Please refer to./java_maven-setup.md to install java environment.
    pause
    EXIT /b 1
) ELSE (
    echo Java �Ѱ�װ���汾��Ϣ:  / Java is already installed, version info: 
    call java -version
)
   

REM ��� Maven �Ƿ��Ѱ�װ / Check if Maven is installed
where mvn >nul 2>nul
IF ERRORLEVEL 1 (
    echo ��ǰ�豸δ��װMaven, �밲װ�����ԡ�/ Maven is not installed. Please install it to continue.
    echo �ɲο� ./java_maven-setup.md ��װjava������/ Please refer to./java_maven-setup.md to install java environment.
    pause
    EXIT /b 1
) ELSE (
    echo Maven ��װ��ɣ��汾��Ϣ: !maven_version! / Maven is already installed, version info:
    call mvn -version
)
   

REM ��װ��Ŀ���� / Install project dependencies
IF EXIST "pom.xml" (
    echo ��ʼ��װ��Ŀ����... / Installing project dependencies...
    call mvn install
) ELSE (
    echo δ�ҵ� pom.xml �ļ�������������װ��/ No pom.xml file found, skipping dependency installation.
    pause
    EXIT /b 1
)
   

REM ������Ŀ / Start the project
echo ������Ŀ... / Starting the project....
mvn spring-boot:run
