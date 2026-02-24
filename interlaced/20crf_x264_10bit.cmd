@echo off
cd /d "%~dp0"

REM Using 10-bit encoding of an 8-bit source can slightly improve compression efficiency and thus reduce file size. I compressed a 1.29GB MPEG2 source to 466MB instead of 474MB.
REM https://www.dr-lex.be/info-stuff/videotips.html https://yukisubs.wordpress.com/wp-content/uploads/2016/10/why_does_10bit_save_bandwidth_-_ateme.pdf https://x266.nl/x264/10bit_03-422_10_bit_pristine_video_quality.pdf

REM - yadif=1:-1 : Deinterlace (Double framerate)
set "VIDEO_ENCODER=libx264 -crf 20 -preset veryslow -x264-params open-gop=1 -flags +ilme+ildct -x264-params "bff=1" -tune film -pix_fmt yuv420p10le"
set "OUTPUT_SUFFIX=_film_10bit"

call "%~dp0..\delivery.cmd" %*