@echo off
REM 500MB Interlaced encoding (optimized for Discord Nitro)
REM 2-Pass libx264 with high quality parameters

set "TARGET_SIZE_KB=3400000"
set "OVERHEAD_KB=10000"
set "PRESET=veryslow"
set "TUNE=film"
set "PIX_FMT=yuv420p"
set "PARAMS=open-gop=1:tff=1:aq-mode=2:fast-pskip=0"
set "FILTERS=setfield=tff"
set "FLAGS=+ilme+ildct"

:loop
if "%~1"=="" goto :end

echo.
echo =========================================================
echo Processing: "%~nx1"
echo =========================================================

REM Get Duration
set "seconds="
for /f "tokens=1 delims=." %%a in ('ffprobe -v error -select_streams v:0 -show_entries format^=duration -of csv^=p^=0 "%~1"') do (
    set "seconds=%%a"
)

REM Fallback if duration extraction failed
if "%seconds%"=="" set seconds=1
set /a seconds=seconds + 0
if %seconds% EQU 0 set seconds=1

echo Duration: ~%seconds% seconds.

REM Calculate Bitrate
set /a video_kbps=TARGET_SIZE_KB / seconds
set /a video_kbps=video_kbps - (OVERHEAD_KB / seconds)

if %video_kbps% LSS 100 set video_kbps=100

echo Target Video Bitrate: %video_kbps%k
echo.

echo --- Running Pass 1 ---
ffmpeg -hide_banner -y -i "%~1" -pix_fmt %PIX_FMT% -c:v libx264 -preset %PRESET% -tune %TUNE% -x264-params "%PARAMS%" -flags %FLAGS% -vf "%FILTERS%" -b:v %video_kbps%k -pass 1 -passlogfile "ff2pass" -an -f null NUL
if %errorlevel% neq 0 goto :error

echo.
echo --- Running Pass 2 ---
ffmpeg -hide_banner -y -i "%~1" -pix_fmt %PIX_FMT% -c:v libx264 -preset %PRESET% -tune %TUNE% -x264-params "%PARAMS%" -flags %FLAGS% -vf "%FILTERS%" -b:v %video_kbps%k -pass 2 -passlogfile "ff2pass" -movflags +faststart -c:a copy "%~n1_interlaced_500MB.mp4"
if %errorlevel% neq 0 goto :error

del /q "ff2pass-0.log" "ff2pass-0.mbtree" 2>nul
echo [SUCCESS] "%~nx1" finished.
echo.

shift
goto :loop

:error
color 0c
echo.
echo #########################################################
echo ERROR DETECTED! Encoding failed on file: "%~nx1"
echo #########################################################
del /q "ff2pass-0.log" "ff2pass-0.mbtree" 2>nul
pause
exit /b 1

:end
echo.
echo =========================================================
echo All files processed.
echo =========================================================
pause
exit /b 0
