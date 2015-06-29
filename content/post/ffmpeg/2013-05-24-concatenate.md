---
title:  Concatenate files with ffmpeg
date:   2012-11-03T19:16:11-06:00
tags: [ffmpeg]
---

Take a list of media files and concatenate them into a single file.

----

### References

  - [FFmpeg Trac Docs](https://trac.ffmpeg.org/wiki/Concatenate)

~~~ sh
for f in *.wav; do echo "file '$f'" >> mylist.txt; done
ffmpeg -f concat -i mylist.txt -c copy output.wav
~~~
