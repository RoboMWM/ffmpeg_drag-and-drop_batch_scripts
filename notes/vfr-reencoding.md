```
-copyts -copytb 1 -enc_time_base demux -fps_mode passthrough -video_track_timescale 90000
```

These preserve (instead of regenerating) source video's timestamps to retain original variable frame rate timing. Useful for some game bar recordings that record incorrect metadata e.g. reporting framerate to be lower (30fps) when it's actually ~60fps VFR. See investigation https://gist.github.com/MLG-SERBUR/c5196d466733a572962d704d2d655553

`video_track_timescale` only applies to MP4 container.

AI-assisted explanation of flags:

* `-enc_time_base demux` use demuxer's time base instead of default (1/framerate)
* `-copytb 1` Use demuxer timebase when stream copying (may not be needed/used as is only applicable during stream copy...)
* `-copyts` preserve input timestamps instead of regenerating or sanitizing them.
* `-video_track_timescale 90000` gives MP4 enough precision, minimizing timestamp rounding
