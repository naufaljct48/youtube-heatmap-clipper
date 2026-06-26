@echo off
setlocal

cd /d "%~dp0"

title YouTube Heatmap Clipper Launcher
cls

echo ===================================================
echo   YouTube Heatmap Clipper - Auto Launcher
echo ===================================================
echo(

set "VENV_DIR=venv"
set "PYTHON_CMD="

if exist "%VENV_DIR%\Scripts\python.exe" set "PYTHON_CMD=%VENV_DIR%\Scripts\python.exe"
if defined PYTHON_CMD goto :DEPS

echo [*] Virtual Environment not found.
echo [*] Trying to create a new venv with Python 3.11...

py -3.11 --version >nul 2>nul
if errorlevel 1 goto :TRY_SYSTEM_PY

echo [OK] Python 3.11 found. Creating venv...
py -3.11 -m venv "%VENV_DIR%"
if errorlevel 1 goto :VENV_FAIL
goto :SET_PY

:TRY_SYSTEM_PY
echo [WARN] Python 3.11 not found on the system.
echo [*] Falling back to the default system 'python'...
python --version >nul 2>nul
if errorlevel 1 goto :NO_PY
python -m venv "%VENV_DIR%"
if errorlevel 1 goto :VENV_FAIL

:SET_PY
if not exist "%VENV_DIR%\Scripts\python.exe" goto :VENV_FAIL
set "PYTHON_CMD=%VENV_DIR%\Scripts\python.exe"
echo [OK] Venv created successfully.

:DEPS
echo(
echo [*] Checking ^& Installing dependencies...
"%PYTHON_CMD%" -m pip install --upgrade pip >nul
"%PYTHON_CMD%" -m pip install -r requirements.txt
if errorlevel 1 goto :REQ_FAIL

echo [*] Checking AI Subtitle dependencies (faster-whisper)...
"%PYTHON_CMD%" -c "import faster_whisper" >nul 2>nul
if errorlevel 1 goto :INSTALL_FWHISPER
echo [OK] faster-whisper already installed.
goto :RUN

:INSTALL_FWHISPER
echo [*] Installing faster-whisper...
"%PYTHON_CMD%" -m pip install faster-whisper
if errorlevel 1 (
    echo [WARN] Failed to install faster-whisper. Subtitle feature may not work.
    echo        (Usually due to an incompatible/preview Python version^)
) else (
    echo [OK] faster-whisper installed.
)

:RUN
echo(
echo ===================================================
echo   IMPORTANT:
echo   Make sure FFmpeg is installed so the crop function works.
echo   If not, install it manually via PowerShell (Administrator^):
echo       winget install Gyan.FFmpeg
echo.
echo   All set! Starting the Web App...
echo   Open your browser at: http://127.0.0.1:5050
echo ===================================================
echo(

if defined YHC_CHECK_ONLY goto :DONE

"%PYTHON_CMD%" webapp.py
goto :DONE

:NO_PY
echo [X] Python was not found at all!
echo     Install Python 3.11 from python.org or the Microsoft Store.
goto :FAIL

:VENV_FAIL
echo [X] Failed to create venv.
goto :FAIL

:REQ_FAIL
echo [X] Failed to install basic dependencies. Check your internet connection.
goto :FAIL

:FAIL
echo(
echo [INFO] Application stopped.
echo Press any key to close this window...
pause
exit /b 1

:DONE
echo(
echo [INFO] Application stopped.
echo Press any key to close this window...
pause
exit /b 0
