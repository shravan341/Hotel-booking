@echo off
echo Starting application...
cd /D "%WORKSPACE%"
start "HotelApp" /MIN npm run start
exit 0
