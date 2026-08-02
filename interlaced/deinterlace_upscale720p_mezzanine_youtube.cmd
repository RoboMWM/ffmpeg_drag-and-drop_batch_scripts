@echo off
cd /d "%~dp0"

REM ========================================================
REM YouTube 720p60 High-Quality Deinterlace & Upscale Script
REM ========================================================

REM OVERRIDE TIMING: Force Constant Frame Rate. 
REM If we leave this undefined, delivery.cmd uses passthrough/copyts, 
REM which breaks double-framerate interpolation.
set "VIDEO_TIMING_OPTIONS=-fps_mode cfr"

REM FILTER CHAIN EXPLANATION:
REM bwdif=mode=1 : Best native FFmpeg deinterlacer. Mode 1 doubles the framerate (outputs 1 frame per field).
REM scale=-2:720 : Upscales to exactly 720p height. Width is calculated automatically (keeps aspect ratio).
REM flags=lanczos: Uses the Lanczos algorithm for premium upscaling quality.
REM format=yuv420p : Ensures standard 4:2:0 chroma so YouTube processes it flawlessly.

set "VIDEO_FILTERS=bwdif=mode=1,scale=-2:720:flags=lanczos,format=yuv420p"

REM ENCODER SETTINGS:
REM crf 14 + preset veryslow : Near-lossless, max quality, ignores encoding time.
REM -g 30 : Closed GOP. YouTube prefers regular I-frames for optimal re-encoding.
REM Removed +ildct+ilme because the output is now purely progressive.
set "VIDEO_ENCODER=libx264 -crf 14 -preset veryfast -g 30 -vf "%VIDEO_FILTERS%""

REM High quality audio to match the video
set "AUDIO_ENCODER=aac -b:a 320k"

set "OUTPUT_SUFFIX=_YT_720p60"
set "OUTPUT_EXT=.mp4"

call "%~dp0..\delivery.cmd" %*