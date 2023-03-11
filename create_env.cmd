@echo off
@setlocal

set ROOT=%~dp0
set ENV_DIR=%ROOT%\.env\colormath
set ACTIVATE=%ENV_DIR%\scripts\activate.bat

echo Creating Virtual Environment
py -3.11 -m venv "%ENV_DIR%"
if errorlevel 1 (
    echo Failed to create venv.
    exit /b 1
)

echo Activating Virtual Environment
call "%ACTIVATE%"
if errorlevel 1 (
    echo Failed to activate environment.
    exit /b 1
)

if "%VIRTUAL_ENV%"=="" (
    echo Failed to activate environment.
    exit /b 1
)

echo Upgrading PIP and Installing Requirements
python -m pip install --upgrade pip
python -m pip install -e "%ROOT%\.[dev]"
if errorlevel 1 (
    echo Failed Install Requirements
    exit /b 1
)

echo Deactivating
call deactivate
if errorlevel 1 (
    echo Failed To Deactivate Environment
    exit /b 1
)

echo DONE
echo Run "%ACTIVATE%" to activate environment.
