@echo off
echo.
title springboot3mybatis
echo [信息] 使用Jar命令运行Web工程。
echo.

cd %~dp0
cd ../shopping/target

set JAVA_OPTS=-Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m

java -jar %JAVA_OPTS% shopping-0.1.jar

cd bin
pause