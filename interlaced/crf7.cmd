@echo off
cd /d "%~dp0"

REM CRF 7 Interlaced (Mezzanine/Archival)
REM -g 1: All-Intra for maximum fidelity and editability
REM -pix_fmt yuv422p: 4:2:2 chroma subsampling (high profile)
REM -flags +ildct+ilme -top 1: Interlaced flags (TFF)
set "VIDEO_ENCODER=libx264 -preset veryslow -crf 7 -g 1 -x264opts "aq-mode=2:no-fast-pskip=1:no-dct-decimate=1" -pix_fmt yuv422p -vf setfield=tff -flags +ildct+ilme"
set "AUDIO_ENCODER=libopus -b:a 64k -vbr on"
set "OUTPUT_SUFFIX=-crf7"
set "OUTPUT_EXT=.mp4"

call "%~dp0..\delivery.cmd" %*
