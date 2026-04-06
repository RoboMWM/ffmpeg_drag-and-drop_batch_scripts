@echo off
cd /d "%~dp0"

REM Crushes dark areas for better compression.
set "VIDEO_FILTERS=-vf "noise=alls=18:allf=t+u,curves=all='0/0 0.2/0 1/1'" -pix_fmt yuv420p"
set "AUDIO_BITRATE=0"
set "AUDIO_ENCODER=copy -an"

call "Dumcord.cmd" %*