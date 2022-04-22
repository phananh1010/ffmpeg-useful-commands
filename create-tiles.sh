#!/usr/bin/env bash

#this script temporally divides a videos into multiple segments, and from a segment, spatially into tiles. This is useful for tile-based streaming projects.
#If a real-world setup for tile-streaming is required, please see my tile-based streaming project at: https://github.com/phananh1010/tile-dash

#INPUT: 
#assume ./data/input_video.mp4 exist in this directory.
#In this file, we will assume the configuration for the video fixed at 3840x1920, and will be divided into 20x10 tiles, each tile of size 384x384.

#OUTPUT: a directory will be created at ./data/input_video/. Video segments and video tiles will be genrated and put into this directory




FP=${1}
base_name=$(basename ${FP})
inputvid_path="$(dirname "${VAR}")" 
inputvid_name=$(echo "$FP" | sed -r "s/.+\/(.+)\..+/\1/")
echo "Processing file: ${FP}" 
echo "creating directory named: ${inputvid_name}"
dir_path=./data/${inputvid_name}
mkdir $dir_path || true #create directory containting tiles
echo "dir created, new data will be put into: ${dir_path}"
echo "remove previous files in ${dir_path}"
rm ${dir_path}/*.mp4 || true
echo "creating segments of 1 second length..."
for segi in {10..11}
#segis=$(`printf "%02d" 03`)
do
    #echo "yes | ffmpeg -ss 00:00:$segi -t 00:00:01  -i $FP -c:v libx264 -c:a copy -an $dir_path/seg${segi}.mp4"
    yes | ffmpeg -ss 00:00:$segi -t 00:00:01  -i $FP -b:v 64k -c:v libx264 -c:a copy -an $dir_path/seg${segi}.mp4
    echo "creating tiles..."
    for hi in {0..3840..384}
    do
        for wi in {0..1920..384}
        do
            #echo "yes | ffmpeg -i $dir_path/seg${segi}.mp4 -vf crop=384:384:${wi}:${hi} $dir_path/seg-${segi}-tile-${wi}-${hi}.mp4 || true"
            yes | ffmpeg -i $dir_path/seg${segi}.mp4 -vf crop=384:384:${wi}:${hi} -b:v 64k $dir_path/seg-${segi}-tile-${wi}-${hi}.mp4 || true
        done
    done
done
