@echo off
cd /d "%~dp0"

REM Progressive encoding
set "VIDEO_ENCODER=libx264 -crf 20 -preset veryslow"
set "AUDIO_ENCODER=copy -an"
set "OUTPUT_SUFFIX=20crf"
set "OUTPUT_EXT=.mp4"

call "%~dp0..\delivery.cmd" %*