---
title:  FFmpeg Oneliners
date:   2012-11-03T19:16:11-06:00
tags: [ffmpeg]
---

Here are a bunch of `ffmpeg` commands that I have collected

~~~ sh
# File Info
ffmpeg -i <file>

# Convert (not transcode)
ffmpeg -i <file> -c copy <file.out>

# Convert lowbitrate -> 128k (to get around iCloud)
ffmpeg -i in.m4a -b:a 128k out.mp3

# Convert, but transcode audio to 2ch AC3
ffmpeg -i <file.mkv> -c:v copy -c:a ac3 -ac 2 <file.mp4>

# Extract Audio Stream (0:1 = 0-First input file  1-Second Stream)
ffmpeg -i Movie.m4v -map 0:1 -acodec copy Movie_Audio.m4a

# Extract Audio Stream (0:1 = 0-First input file  1-Second Stream)
#   Copy 5 minutes from 25 min in (1500s=25m, 300s=5m)
ffmpeg -i Movie.m4v -map 0:1 -acodec copy -ss 1500 -t 300 Movie_Audio.m4a

# Convert audio file to iTunes format (works with non-standard extensions, like m4b)
ffmpeg -i audio.mp3 -f adts -c:a libfdk_aac audio.m4b

# Convert all MP3 files to AAC, then rename to M4B (for audiobooks)
for f in *.mp3; do ffmpeg -i $f  -c:a libfdk_aac ${f:r}.m4a && mv ${f:r}.m4a ${f:r}.m4b; done
for f in *.mp3; do ffmpeg -i $f -f adts -c:a libfdk_aac ${f:r}.m4b; done
for f in *.mp3; do ffmpeg -i $f -acodec libfdk_aac -b:a 96k -f adts ${f:r}.m4b; done

# Convert to AAC/M4A that will import into iTunes
ffmpeg -i Input.mp3 -c:a libfdk_aac Test96.m4a
#     If you want a different file extension, specify iPod format:
ffmpeg -i Input.mp3 -c:a libfdk_aac -f ipod -b:a 96k Test96.m4b

# Convert all FLAC->M4A, using separate folders
mkdir aac; mkdir processed; for f in *.flac; do
  ffmpeg -i $f -acodec libfdk_aac -b:a 256k "aac/${f:t:r}.m4a" && mv $f processed/; done
# Simple FLAC conversion
for f in *.flac; do ffmpeg -i $f -c:a libfdk_aac -ab 256k ${f:r}.m4a; done

# Take an input that has 0:0-h264 0:1-ac3 and output a file that copies those and adds an AAC channel
# Notice the duplicated input, this is so we can copy one audio, but process the other
ffmpeg -i movie.m4v -i movie.m4v -map 0:0 -c:v copy -map 0:1 -c:a:0 copy -map 1:1 -c:a:1 libfdk_aac movie_fixed.m4v

# Convert flash demo video to h264/m4v mono
ffmpeg -i dd6796a8c742c83457e1d7a32985cc5e.flv -c:v h264 -c:a libfdk_aac -ac:1 1 -ab:1 48k SCID-workshop2.m4v
~~~
