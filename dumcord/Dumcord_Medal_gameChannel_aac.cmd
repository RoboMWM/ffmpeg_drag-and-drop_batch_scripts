@echo off
cd /d "%~dp0"

REM Only game audio with AAC reencoding
set "AUDIO_ENCODER=aac -map 0:v -map 0:a:1"
set "AUDIO_BITRATE=200000"
set "MAP_OPTIONS="
set "OUTPUT_SUFFIX=_Dumcord_Medal_aac"

call "Dumcord.cmd" %*