@echo off
echo Library Management System - Quick Start
echo ======================================
echo.

REM Check for PHP in common locations
set PHP_PATH=

if exist "C:\xampp\php\php.exe" (
    set PHP_PATH=C:\xampp\php\php.exe
    echo Found PHP at: C:\xampp\php\php.exe
) else if exist "C:\wamp64\bin\php\php*\php.exe" (
    for /d %%i in ("C:\wamp64\bin\php\php*") do (
        set PHP_PATH=%%i\php.exe
        echo Found PHP at: %%i\php.exe
        goto :found_php
    )
)

:found_php
if "%PHP_PATH%"=="" (
    REM Try PHP in PATH
    php --version >nul 2>&1
    if %errorlevel%==0 (
        set PHP_PATH=php
        echo PHP found in PATH
    ) else (
        echo ERROR: PHP not found!
        echo.
        echo Please install PHP or XAMPP/WAMP:
        echo - XAMPP: https://www.apachefriends.org/
        echo - WAMP: https://www.wampserver.com/
        echo.
        pause
        exit /b 1
    )
)

echo.
echo Starting PHP development server...
echo Server will be available at: http://localhost:8000
echo Press Ctrl+C to stop the server
echo.

"%PHP_PATH%" -S localhost:8000



