@echo off
@setlocal enableextensions
@cd /d "%~dp0"
setlocal
cls

if not exist ".\EULA.txt" (
goto END
)

type ".\EULA.txt" | more
echo.
set /P AREYOUSURE=SURE, I TAKE THE RISK. I AGREE (Y/[N])?
if /I "%AREYOUSURE%" neq "Y" goto END

echo.
echo Installing Tuersteher ...
echo.

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT goto 32BIT
if %OS%==64BIT goto 64BIT
goto END

if not exist "C:\Windows\Tuersteher.ini" (
xcopy /Y /R ".\Tuersteher.ini" C:\Windows\
)

:32BIT
xcopy /Y /R ".\x86\Tuersteher.sys" C:\Windows\System32\drivers\
xcopy /Y /R ".\x86\Tuersteher.inf" C:\Windows\System32\
xcopy /Y /R ".\x86\Tuersteher.cat" C:\Windows\System32\
xcopy /Y /R ".\x86\Tuersteher.sys" C:\Windows\System32\
RUNDLL32.EXE SETUPAPI.DLL,InstallHinfSection DefaultInstall 132 .\x86\Tuersteher.inf
reg IMPORT ".\Signal.reg"
goto DRIVER_DONE

:64BIT
xcopy /Y /R ".\x64\Tuersteher.sys" C:\Windows\System32\drivers\
xcopy /Y /R ".\x64\Tuersteher.inf" C:\Windows\System32\
xcopy /Y /R ".\x64\Tuersteher.cat" C:\Windows\System32\
xcopy /Y /R ".\x64\Tuersteher.sys" C:\Windows\System32\
RUNDLL32.EXE SETUPAPI.DLL,InstallHinfSection DefaultInstall 132 .\x64\Tuersteher.inf
reg IMPORT ".\Signal.reg"

:DRIVER_DONE
xcopy /Y /R ".\Tools\EventSource.dll" C:\Windows\System32\
ren "C:\Windows\System32\EventSource.dll" "TuersteherEventSource.dll"
reg IMPORT ".\Tools\EventSource_Tuersteher.reg"

:END
pause