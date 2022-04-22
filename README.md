# ffmpeg-useful-commands
Here is the list of frequently used ffmpeg command

#### Extract a video segment (from 00:00s to 1:00s, change resolution, change framerate, remove audio, specify encoder)
```
ffmpeg -ss 00:00:00 -to 00:01:00  -i ./raw/paris.mp4 -vf "scale=3840:1920 , fps=fps=27" -c:v libx264 -c:a copy -an ./paris.mp4
```

#### Spatially crop video
```
ffmpeg -i input -vf crop=[width]:[height]:[posx]:[poxy] output
```
This command is useful to create video tiles. For more detail, see `create-tiles.sh` script

#### Change video bitrate and resolution
```
ffmpeg -i ./bicycle.mp4 -vf "scale=120:-1" -b:v 64k bicycle_b64k_120x.mp4
```

#### Extract frame at a given time
```
ffmpeg -ss 00:00:02.34 -i ../bicycle.mp4 -frames:v 1 -q:v 2 ./bicycle_b1248k_480x/frame_0002.34.jpg
```
