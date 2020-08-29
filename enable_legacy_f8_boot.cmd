@echo off
@echo off
@setlocal enableextensions
@cd /d "%~dp0"
setlocal
cls

echo ! ! ! BEWARE ! ! !
echo THIS OPTION IS FOR DEBUGGING ONLY.
echo POTENTIAL SECURITY RISKS MAY ARISE.
echo.
echo Do you really want to enable the legacy F8 Boot option?
set /P AREYOUSURE=Yes, I know what I do. (Y/[N])?
if /I "%AREYOUSURE%" neq "Y" goto END

bcdedit /set {default} bootmenupolicy legacy
bcdedit /timeout 12

:END
pause
