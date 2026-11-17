@echo off
cd /d "%~dp0"
set ADB=adb
if exist "%~dp0platform-tools\adb.exe" set "ADB=%~dp0platform-tools\adb.exe"

echo ============================================
echo  REDMI Turbo 4 一键去臃肿 (HyperOS)
echo  不需要 root / 不丢数据 / 可恢复
echo ============================================
echo.

"%ADB%" start-server >nul 2>&1
if errorlevel 1 (
    echo 找不到 adb，请确认 platform-tools 已解压，
    echo 且本脚本与 platform-tools 文件夹在同一目录。
    pause
    exit /b 1
)

echo 已连接的设备：
"%ADB%" devices
echo.
"%ADB%" devices | findstr /r /c:"device$" >nul
if errorlevel 1 (
    echo 没检测到手机：检查 USB 线，确认手机上点了"允许 USB 调试"。
    pause
    exit /b 1
)
echo 检测到手机，按任意键开始卸载...
pause >nul

echo.
echo 开始卸载臃肿应用（显示 Failure [not installed] 表示这版本没预装，跳过即可）
echo --------------------------------------------

call :rm com.miui.msa.global "MSA 系统广告服务（广告总闸）"
call :rm com.miui.systemAdSolution "系统广告解决方案组件"
call :rm com.miui.analytics "系统数据统计"
call :rm com.mobiletools.systemhelper "SystemHelper（后台上传组件）"
call :rm com.miui.bugreport "用户反馈"
call :rm com.xiaomi.bugreport "用户反馈"
call :rm com.miui.yellowpage "黄页"
call :rm com.xiaomi.glgm "游戏中心"
call :rm com.miui.fm "FM 收音机"
call :rm com.duokan.reader "多看阅读"
call :rm com.android.email "系统自带邮件"

echo 分身空间专属（仅 Turbo 4 有，如无分身空间会显示 Failure，跳过即可）
call :rm999 com.miui.analytics "分身空间（user 999）小米统计"

echo --------------------------------------------
echo 完成！建议重启手机。
echo 如误删：运行 restore.bat 可恢复。
pause
exit /b 0

:rm
echo [%1] %~2
"%ADB%" shell pm uninstall --user 0 %1
echo.
goto :eof

:rm999
echo [%1] %~2
"%ADB%" shell pm uninstall --user 999 %1
echo.
goto :eof