@echo off
cd /d "%~dp0"

set "VIDEO_ENCODER=libx265 -preset veryslow -tag:v hvc1 -x265-params open-gop=1"
set "OUTPUT_SUFFIX=_dumcord_veryslow"

call "Dumcord.cmd" %*