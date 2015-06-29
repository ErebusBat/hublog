---
title:  Install full ffmpeg Homebrew
date:   2012-11-03T19:16:11-06:00
tags: [ffmpeg]
---

Will install `ffmpeg` with all the codecs that I care about (namely fdk-aac).
~~~ bash
brew install ffmpeg \
  --with-fdk-aac \
  --with-ffplay \
  --with-freetype \
  --with-frei0r \
  --with-libass \
  --with-libcaca \
  --with-libvo-aacenc \
  --with-libvorbis \
  --with-libvpx \
  --with-opencore-amr \
  --with-openjpeg \
  --with-openssl \
  --with-opus \
  --with-rtmpdump \
  --with-schroedinger \
  --with-speex \
  --with-theora \
  --with-tools
~~~
