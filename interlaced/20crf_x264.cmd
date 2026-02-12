@echo off
cd /d "%~dp0"

REM - yadif=1:-1 : Deinterlace (Double framerate)
set "VIDEO_ENCODER=libx264 -crf 20 -preset veryslow -x264-params open-gop=1 -flags +ilme+ildct -tune film"
REM -x264-params "bff=1"
set "OUTPUT_SUFFIX=_film"

call "%~dp0..\delivery.cmd" %*