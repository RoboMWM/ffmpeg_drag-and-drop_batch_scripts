Perform a zoom crop:

```
ffmpeg -i MedalTVMarvelRivals20260722215503477-trim-1784783940857-00.00.00.000-00.01.59.778-00.01.07.600-00.01.59.766-00.00.00.000-00.00.51.991-00.00.21.992-00.00.24.792-seg2.mp4 -c:v libx264 -crf 4 -vf "crop=672:378:616:64,scale=1920:1080:flags=lanczos,setsar=1" -c:a copy output.mp4
```