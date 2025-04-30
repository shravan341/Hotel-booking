@echo off
echo Stopping any existing Node processes...
taskkill /F /IM node.exe /T > nul 2>&1
taskkill /F /IM cmd.exe /T > nul 2>&1
exit 0
