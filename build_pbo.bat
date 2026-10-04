@echo off
setlocal
set "SOURCE=%~dp0addons\DU_Commander"
set "DEST=%~dp0@DU_Commander\addons"
if not exist "%SOURCE%\config.cpp" exit /b 1
if not exist "%DEST%" mkdir "%DEST%"
echo Source: %SOURCE%
echo Destination: %DEST%
echo Prefix: du_commander
pause
