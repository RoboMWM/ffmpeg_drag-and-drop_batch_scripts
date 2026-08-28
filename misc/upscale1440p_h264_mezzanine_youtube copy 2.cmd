@echo off
cd /d "%~dp0"

REM ========================================================
REM YouTube 1440p60 High-Quality Upscale Script
REM ========================================================

REM FILTER CHAIN EXPLANATION:
REM scale=-2:1440 : Upscales to exactly 1440p height. Width is calculated automatically (keeps aspect ratio).
REM flags=lanczos: Uses the Lanczos algorithm for premium upscaling quality.

set "VIDEO_FILTERS=scale=-2:1440:flags=lanczos"

REM ENCODER SETTINGS:
REM -g 30 : Closed GOP. YouTube prefers regular I-frames for optimal re-encoding.
set "VIDEO_ENCODER=libx264 -crf 7 -preset superfast -g 30 -vf "%VIDEO_FILTERS%""

set "OUTPUT_SUFFIX=_YT_1440p60"
set "OUTPUT_EXT=.mp4"

call "%~dp0..\delivery.cmd" %*