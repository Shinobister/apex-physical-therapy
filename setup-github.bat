@echo off
REM GitHub Repository Setup Script for Windows
REM This script helps you connect this project to GitHub and deploy to Netlify

echo === GitHub Repository Setup ===
echo.

REM Check if git is available
where git >nul 2>nul
if errorlevel 1 (
    echo Error: git is not installed or not in PATH
    pause
    exit /b 1
)

REM Get current directory name
for %%I in (.) do set CURRENT_DIR=%%~nxI
echo Current directory: %CURRENT_DIR%
echo.

REM Ask for GitHub information
set /p GITHUB_USERNAME="Enter your GitHub username: "
set /p REPO_NAME="Enter repository name (default: apex-physical-therapy): "
if "%REPO_NAME%"=="" set REPO_NAME=apex-physical-therapy

REM Check if remote already exists
git remote get-url origin >nul 2>nul
if not errorlevel 1 (
    echo Warning: git remote 'origin' already exists.
    set /p OVERWRITE="Do you want to overwrite it? (y/N): "
    if /i not "%OVERWRITE%"=="y" (
        echo Aborting.
        pause
        exit /b 1
    )
    git remote remove origin
)

REM Set up remote
echo.
echo Setting up remote: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git
git remote add origin https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git

echo.
echo === Next Steps ===
echo 1. Create a new repository on GitHub:
echo    - Go to https://github.com/new
echo    - Repository name: %REPO_NAME%
echo    - Description: "Apex Physical Therapy website - High-Transparency Clinical Minimalism design"
echo    - DO NOT initialize with README, .gitignore, or license
echo    - Click "Create repository"
echo.
echo 2. Push your code:
echo    Run the following commands:
echo    git branch -M main
echo    git push -u origin main
echo.
echo 3. Deploy to Netlify:
echo    - Go to https://app.netlify.com
echo    - Sign up/login
echo    - Click "New site from Git"
echo    - Choose GitHub, authorize, select your repository
echo    - Build settings: leave blank (static site)
echo    - Click "Deploy site"
echo.
echo 4. Your site will be live at: https://[random-name].netlify.app
echo    You can add a custom domain later.
echo.
echo Script complete. Follow the steps above to deploy your website.
pause