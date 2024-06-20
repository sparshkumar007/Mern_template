@echo off
setlocal enabledelayedexpansion

:: Variables for the script
set REPO_URL=https://github.com/sparshkumar007/Mern_template/
set CLONE_DIR=Mern_template
set NEW_PROJECT_NAME=%1

:: Check if project name is provided
if "%NEW_PROJECT_NAME%"=="" (
    echo Please provide a name for the new project. e.g. setup_mern_template.bat test
    exit /b 1
)

:: Check if git is installed
where git >nul 2>nul
if errorlevel 1 (
    echo Git is not installed. Please install git and try again.
    exit /b 1
)

:: Git is installed, proceed with cloning the repository
echo Git found. Cloning the repository...
git clone %REPO_URL%

:: Check if the clone was successful
if errorlevel 1 (
    echo Failed to clone the repository.
    exit /b 1
)

echo Repository cloned successfully.

:: Rename the project directory
echo Renaming the project directory to %NEW_PROJECT_NAME%...
rename %CLONE_DIR% %NEW_PROJECT_NAME%

cd %NEW_PROJECT_NAME%

echo Deleting the script file...
del %~nx0

:: Remove the .git directory
echo Deleting the .git directory...
rmdir /s /q .git

echo Deleting the README.md file...
del README.md

:: Check if npm is installed
where npm >nul 2>nul
if errorlevel 1 (
    echo npm is not installed. Please install npm and try again.
    exit /b 1
)

echo npm found. Installing dependencies...

if exist frontend (
    echo Entering frontend folder...
    cd frontend

    :: Run npm install
    echo Running npm install...
    npm install

    echo npm install completed.

    echo Navigating back to the parent directory...
    cd ..
) else (
    echo Frontend folder not found.
    exit /b 1
)

if exist backend (
    echo Entering backend folder...
    cd backend

    :: Run npm install
    echo Running npm install in backend...
    npm install

    echo npm install completed in backend.

    :: Navigate back to the parent directory
    echo Navigating back to the parent directory...
    cd ..
) else (
    echo Backend folder not found.
    exit /b 1
)

:: Check if VS Code is installed
where code >nul 2>nul
if errorlevel 1 (
    echo VS Code is not installed. Skipping opening the directory.
) else (
    echo VS Code found. Opening the current directory in VS Code...
    code .
)

echo Setup completed successfully.
