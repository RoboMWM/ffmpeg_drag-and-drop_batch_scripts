cd /d "%~dp0"

REM Using 10-bit encoding of an 8-bit source can slightly improve compression efficiency and thus reduce file size. I compressed a 1.29GB MPEG2 source to 466MB instead of 474MB.
REM https://www.dr-lex.be/info-stuff/videotips.html https://yukisubs.wordpress.com/wp-content/uploads/2016/10/why_does_10bit_save_bandwidth_-_ateme.pdf https://x266.nl/x264/10bit_03-422_10_bit_pristine_video_quality.pdf

REM set "INPUT_OPTIONS=-field_order tt"
set "VIDEO_ENCODER=libx264 -crf 20 -preset veryslow -tune film -flags +ilme+ildct -x264-params open-gop=1:tff=1 -vf setfield=tff -pix_fmt yuv422p10le -profile:v high422"
set "OUTPUT_SUFFIX=_film"
set "OUTPUT_EXT=.mp4"
set "Output_DIR=W:\Video\20crf_x264_422_10bit\"
set "AUDIO_ENCODER=libopus -b:a 96k -vbr on

call "%~dp0..\delivery.cmd" %*