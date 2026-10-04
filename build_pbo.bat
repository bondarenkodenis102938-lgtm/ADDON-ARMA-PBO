@echo off
setlocal

set "SOURCE=%~dp0addons\DU_Commander"
set "DEST=%~dp0@DU_Commander\addons"

if not exist "%SOURCE%\config.cpp" (
    echo ERROR: Source addon not found:
    echo %SOURCE%
    exit /b 1
)

if not exist "%DEST%" mkdir "%DEST%"

echo.
echo DU Commander - Addon Builder
echo Source:      %SOURCE%
echo Destination: %DEST%
echo.
echo Use Arma 3 Tools Addon Builder with:
echo   Addon source directory: %SOURCE%
echo   Destination:           %DEST%
echo   Addon prefix:           du_commander
echo   List of files to copy directly: *.sqf
echo.
pause