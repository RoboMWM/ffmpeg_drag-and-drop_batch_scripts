@echo off
cd /d "%~dp0"

REM - yadif=1:-1 : Deinterlace (Double framerate)
set "VIDEO_ENCODER=libsvtav1 -crf 40 -preset 4 -vf "yadif=1:-1""
set "AUDIO_ENCODER=libopus -b:a 160k -vbr on -compression_level 10"
set "OUTPUT_SUFFIX=_deint"
set "OUTPUT_EXT=.mkv"

call "%~dp0..\delivery.cmd" %*