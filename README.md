# ffmpeg-useful-commands
Here is the list of frequently used ffmpeg command

#### Extract a video segment, change resolution, remove audio
```
ffmpeg -ss 00:00:25 -to 00:00:30  -i car1_raw.mp4 -vf "scale=480:-1" -c:v libx264 -c:a copy -an car1.mp4
```
#### Change video bitrate and resolution
```
ffmpeg -i ./bicycle.mp4 -vf "scale=120:-1" -b:v 64k bicycle_b64k_120x.mp4
```

#### Extract frame at a given time
```
ffmpeg -ss 00:00:02.34 -i ../bicycle.mp4 -frames:v 1 -q:v 2 ./bicycle_b1248k_480x/0002.34.jpg
```
