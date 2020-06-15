@echo off&setlocal enabledelayedexpansion
:base64_comp_create
set base64_comp_create_times=0
:base64_comp_recreat
set /a base64_compo_random=%random%%%64+1
for /l %%i in (1 1 %base64_comp_create_times%) do if %base64_compo_random% equ %base64_comp_existed_data_%%i% goto base64_comp_recreat
set base64_comp_existed_data_!base64_comp_create_times!=%base64_compo_random%
if %base64_comp_create_times% equ 64 exit /b
set /a base64_comp_create_times+=1
goto base64_comp_recreat