@echo off
setlocal

if exist "C:\Lawns\GreenCut\" (
    set "REPO=C:\Lawns\GreenCut"
) else (
    set "REPO=C:\Users\Blake\Desktop\GreenCut"
)

echo [GreenCut] Using repo at %REPO%
echo [GreenCut] Stopping server on port 5003...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":5003 " ^| findstr "LISTENING" 2^>nul') do (
    taskkill /PID %%a /F >nul 2>&1
)
timeout /t 2 /nobreak >nul

echo [GreenCut] Pulling latest from git...
git -C "%REPO%" pull

echo [GreenCut] Starting server (lawns.blakecollins.dev -> port 5003)...
start "GreenCut" cmd /k python "%REPO%\physio1\app.py"

echo [GreenCut] Done.
