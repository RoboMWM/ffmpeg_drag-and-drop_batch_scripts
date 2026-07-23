This script concatenates, stretches any cropped videos to fit aspect ratio (doesn't pad with black bars as I attempted to have it do so), and upscales to 2K. Probably needs updating (it works but likely doesn't need things like `$dir` set anymore, the list of files doesn't need `file` nonsense, etc.) as it started off as a bitstream concatenate.

Intended as a mezzanine to upload to YouTube, replace with nvenc if available.

```powershell
$dir = "D:\user\Videos\marvelrivalsbloodhunt"

# 1. Read files from list.txt and strip out 'file' quotes
$files = Get-Content "$dir\list.txt" | ForEach-Object {
    $_ -replace "^file\s+'?", "" -replace "'?$", ""
} | Where-Object { $_ -match "\S" }

# 2. Build input arguments array
$iArgs = @()
foreach ($file in $files) {
    $iArgs += "-i"
    $iArgs += $file
}

# 3. Fit each clip inside 2560x1440 without stretching, pad with black bars, and set SAR 1:1
$scaleFilters = ""
$concatInputs = ""

for ($i = 0; $i -lt $files.Count; $i++) {
    $scaleFilters += "[$($i):v]scale=2560:1440:force_original_aspect_ratio=decrease:flags=lanczos,pad=2560:1440:(ow-iw)/2:(oh-ih)/2:color=black,setsar=1[v$i]; "
    $concatInputs += "[v$i][$($i):a]"
}

$filter = "${scaleFilters}${concatInputs}concat=n=$($files.Count):v=1:a=1[outv][acat]"

# 4. Execute FFmpeg with NVENC
# -c:v h264_nvenc -preset p6 -tune hq -rc constqp -qp 15 -pix_fmt yuv420p `
ffmpeg -hide_banner @iArgs -filter_complex $filter -map "[outv]" -map "[acat]" `
  -c:v libx264 -preset superfast -crf 4 -pix_fmt yuv420p `
  -c:a aac -b:a 195k -movflags +faststart `
  -y "$dir\MedalTVMarvelRivals_2K_merged.mp4"
```