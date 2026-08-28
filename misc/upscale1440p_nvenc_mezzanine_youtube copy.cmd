@echo off
cd /d "%~dp0"

REM ========================================================
REM YouTube 1440p60 High-Quality Upscale Script
REM This pushes like 500mbps it's kinda insane
REM ========================================================

REM 1. UPLOAD TO GPU & SCALE USING CUDA
REM hwupload_cuda: Pushes the CPU-decoded frames into your graphics card's VRAM.
REM scale_cuda: Uses the GPU to upscale to 1440p using the Lanczos algorithm.
REM 2. LOSSLESS GPU ENCODING (HEVC/H.265 Recommended for file size)
set "VIDEO_ENCODER=hevc_nvenc -preset p7 -tune lossless -vf "hwupload_cuda,scale_cuda=-2:1440:interp_algo=lanczos:format=yuv420p""

REM 3. CONTAINER
set "OUTPUT_EXT=.mp4"

set "OUTPUT_SUFFIX=_YT_1440p60"

call "%~dp0..\delivery.cmd" %*