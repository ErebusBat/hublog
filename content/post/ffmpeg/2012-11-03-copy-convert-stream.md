+++
title = "Copy & Convert Single Stream with FFmpeg"
date  = "2012-11-03T19:16:11-06:00"
tags  = ["ffmpeg"]
+++

Assume you have a video with AC3 audio, but you want AC3 *and* AAC audio in the output.

The trick is the double `-i` to get another input to pump into `-map 1:`

~~~ sh
$ ffmpeg -i video.mkv -i video.mkv \
  -map 0:1 -c:v:0 copy \                  # Copy video from stream 1
  -map 0:0 -c:a:0 copy \                  # Copy audio from stream 0
  -map 1:0 -c:a:1 libfdk_aac -ac:2 2 \    # Convert audio in stream 0 to AAC
  video.m4v
~~~
