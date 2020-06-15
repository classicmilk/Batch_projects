@echo off&setlocal EnableDelayedExpansion&color 0a&chcp 936>nul&cls

set ser=http://www.xastudio.top
set temp=%cd%\temp-files
set tmp=%cd%\temp-files
set serhim=%ser%/BatchProjects/HIM/system
set bin=%cd%\bin

if not exist "%temp%" md %temp%
if "%~1"=="Criteria" set himV=Criteria& goto main

exit /b 2002

:main
if not "%~2"=="" set HIM-ver=%~2
if not "%~3"=="" set temp=%~3
call:iget "!serhim!/HIM_!himV!.ver" HIM_!himV!.ver

exit /b 2202
echo ==========================DEBUG
echo Latest version--!netinfo!
echo Inner version---!HIM-ver!
echo PARAMENT^<1^>^:%~1
echo PARAMENT^<2^>^:%~2
echo PARAMENT^<3^>^:%~3
echo ==========================DEBUG
if not "!netinfo!"=="!HIM-ver!" goto install
exit /b 1001
:install
title Discovered New Version 
call:iget "!serhim!/update-address.ifo" update-address.ifo
set old=%cd%
call:rd-word 10
md %temp%\!rd-word!
title INSTALLING
copy /y .\bin\compress.exe %temp%\!rd-word! >nul || exit /b 4001
copy /y .\bin\wget.exe %temp%\!rd-word! >nul || exit /b 4001
copy /y .\bin\libssl32.dll %temp%\!rd-word! >nul || exit /b 4001
copy /y .\bin\libeay32.dll %temp%\!rd-word! >nul || exit /b 4001
cd /d %temp%\!rd-word!
wget -q --no-check-certificate !update-add! >nul
for /f "tokens=1-2 delims=." %%i in ('dir /b *.zip') do compress %%i.zip
cd /d !old!
title OPENNING
::???install.bat?zip?????????????????????
call %temp%\!rd-word!\!zipfile!\install.bat
exit /b 010 || exit

:iget
::HTTP??  ??????
call .\bin\wget -q --no-check-certificate "%~1"
set/p netinfo=<%~2||echo.File Not Exist. inload failed.
exit /b

:rd-word
set num=0 & set word=qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM
set rd-word=
:rd-word-main
if !num! equ %~1 exit /b
set /a rd=%random%%%53
set rd-word=!rd-word!!word:~%rd%,1!
set /a num+=1
goto rd-word-main