@echo off
cd /d "%~dp0"
set ADB=adb
if exist "%~dp0platform-tools\adb.exe" set "ADB=%~dp0platform-tools\adb.exe"

echo ============================================
echo  恢复被卸载的系统应用
echo ============================================
echo.

"%ADB%" start-server >nul 2>&1
if errorlevel 1 (
    echo 找不到 adb，请确认 platform-tools 已解压，
    echo 且本脚本与 platform-tools 文件夹在同一目录。
    pause
    exit /b 1
)

"%ADB%" devices | findstr /r /c:"device$" >nul
if errorlevel 1 (
    echo 没检测到手机：检查 USB 线，确认手机上点了"允许 USB 调试"。
    pause
    exit /b 1
)

echo 开始恢复...
echo --------------------------------------------
call :rs com.miui.msa.global
call :rs com.miui.systemAdSolution
call :rs com.miui.analytics
call :rs com.mobiletools.systemhelper
call :rs com.miui.bugreport
call :rs com.xiaomi.bugreport
call :rs com.miui.yellowpage
call :rs com.xiaomi.glgm
call :rs com.miui.fm
call :rs com.duokan.reader
call :rs com.android.email

echo 分身空间专属（仅 Turbo 4 有）
call :rs999 com.miui.analytics
echo --------------------------------------------
echo 完成！建议重启手机。
pause
exit /b 0

:rs
echo 正在恢复 %1 ...
"%ADB%" shell pm install-existing --user 0 %1
echo.
goto :eof

:rs999
echo 正在恢复 %1（分身空间 user 999）...
"%ADB%" shell pm install-existing --user 999 %1
echo.
goto :eof