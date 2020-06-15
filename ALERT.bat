@mode 30,10&@echo off&setlocal enableDelayedExpansion&color 0a&title Alert
echo.Initializing...
call:verify_array
set himser=http://xastudio.top/BatchProjects/HIM/system/main.php
set "himset=!himser!?key=admin&sig=!verifyNum!"
    (
        echo On Error Resume Next
        echo Dim http
        echo Set http = CreateObject^("Msxml2.ServerXMLHTTP"^)
        echo http.open "GET",WScript.Arguments^(0^),False
        echo http.send
        echo IF http.status = "200" Then
        echo If WScript.Arguments^(1^) = "1" then WScript.echo http.responsetext
        echo else
        echo WScript.echo "error"
        echo end if
    ) > %temp%\xqir.vbs
call:xnet up "!himset!&action=delete&filename=users/alertback.txt"||goto error
:aas
cls
set netinfo_=!netinfo!
call:xnet up "!himset!&action=create&filename=users/alert.txt&fileContent=[!date!-!time!]"||goto error
echo,ALERT has sent
echo,Waiting respond....
:wait
call:xnet up "!himset!&action=read&filename=users/alertback.txt"||goto error
if "!netinfo!"=="ERROR" goto wait
if "!netinfo!"=="!netinfo_!" goto wait
start /b mshta vbscript:msgbox("Respond - - - > !netinfo!")(window.close)
pause>nul
exit

:error
echo.[!time!]^:Sorry, there's no internet connection
pause>nul
exit



:xnet
::Parament 1 ==> METHOD get, up
::Parament 2 ==> ADDRESS
::Information would echo to variable "netinfo"
::XNET - 3.0
set trytime=0
if /i "%~1"=="get" (set xnetNum=0) else (set xnetNum=1)
:broken_99
for /f "tokens=* delims=" %%i in ('cscript //nologo %temp%\xqir.vbs %2 !xnetNum! ^|^|goto error') do set netinfo=%%i
if "!netinfo!"=="" (
    set /a trytime+=1
    if !trytime! equ 10 (set netinfo=ERROR&exit /b 2) else (goto broken_99)
)
exit /b 0

:verify_array
:0again
set e=4
set aa=%random:~1,1%
set b=%random:~2,1%
set c=%random:~3,1%
set /a d=%random%%%2
if !d! equ 0 set e=9
set f=!aa!!b!!c!!d!!e!00
if "!f:~6!"=="" goto 0again
set /a g=!aa!+!b!+!c!+!d!+!e!
set /a h=%g%%%9
set i=8
if not !h! equ 0 set /a i=8-!h!
set verifyNum=!aa!!b!!c!!d!!e!000!i!
exit/b
