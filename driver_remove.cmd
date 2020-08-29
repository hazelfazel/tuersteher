@echo off
@setlocal enableextensions
@cd /d "%~dp0"
setlocal
cls

echo.
echo "  ___________                            __         .__                    "
echo "  \__    ___/_ __   ___________  _______/  |_  ____ |  |__   ___________   "
echo "    |    | |  |  \_/ __ \_  __ \/  ___/\   __\/ __ \|  |  \_/ __ \_  __ \  "
echo "    |    | |  |  /\  ___/|  | \/\___ \  |  | \  ___/|   Y  \  ___/|  | \/  "
echo "    |____| |____/  \___  >__|  /____  > |__|  \___  >___|  /\___  >__|     "
echo "                       \/           \/            \/     \/     \/         "
echo "        Copyright 2011 - 2020 by HazelFazel (hazelfazel@bitnuts.de)        "
echo.

echo Do you really want to remove the Tuersteher driver and its components?
echo.
set /P AREYOUSURE=YES PLEASE, REMOVE TUERSTEHER (Y/[N])?
if /I "%AREYOUSURE%" neq "Y" goto end

echo.
echo Removing Tuersteher ...
echo.

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT goto 32BIT
if %OS%==64BIT goto 64BIT
goto END

:32BIT
taskkill /IM "TuersteherTray_x86.exe" /F
taskkill /IM "TuersteherTrayHelper_x86.exe" /F
taskkill /IM "TuersteherTray_x86.exe" /F
del /f /s /q "C:\Program Files (x86)\Excubits\Tuersteher\*"
rmdir /s /q "C:\Program Files (x86)\Excubits\Tuersteher\"
goto REMOVE_DRIVER

:64BIT
taskkill /IM "TuersteherTray_x64.exe" /F
taskkill /IM "TuersteherTrayHelper_x86.exe" /F
taskkill /IM "TuersteherTray_x64.exe" /F
del /f /s /q "C:\Program Files\Excubits\Tuersteher\*"
rmdir /s /q "C:\Program Files\Excubits\Tuersteher\"
goto REMOVE_DRIVER

:REMOVE_DRIVER
sc stop Tuersteher
sc delete Tuersteher

del /f /q "C:\Windows\System32\drivers\Tuersteher.sys"
del /f /q "C:\Windows\System32\Tuersteher.inf"
del /f /q "C:\Windows\System32\Tuersteher.cat"
del /f /q "C:\Windows\System32\Tuersteher.sys"
del /f /q "C:\Windows\System32\TuersteherEventSource.dll"

REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\Tuersteher" /f /va
REG DELETE "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\Tuersteher" /f
REG DELETE "HKLM\SOFTWARE\Excubits\Tuersteher" /f /va
REG DELETE "HKLM\SOFTWARE\Excubits\Tuersteher" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Tuersteher" /f

:END
pause