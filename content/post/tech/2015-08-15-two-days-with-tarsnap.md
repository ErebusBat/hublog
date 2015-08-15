+++
Categories = []
Description = ""
Tags = ["tech", "tarsnap"]
date = "2015-08-15T06:38:32-06:00"
title = "Two days with tarsnap"
+++

I have been using [Tarsnap](https://www.tarsnap.com) in 'production' for two full days now.

And by production I mean it has been running on my laptop mostly without intervention.
<!--more-->
And by mostly without intervention I mean that I have only had to touch it either out of curiosity or to add missing content.

## Workflow
I have compiled [a page just for tarsnap field notes](/2015/08/tarsnap-field-notes/).

Although tarsnap can easily be run as a one off command or a very custom command in my crontab, it because quickly obvious that this would not scale or maintain well.

This led me to [Tarsnapper](https://github.com/miracle2k/tarsnapper) which is a wrapper around tarsnap which does two things:

- Lets you define "backup jobs" (tarsnap invocations) in a config file,
  though on it's own this has little advantage over just using a a shell
  script.

- The ability to expire old backups using a Grandfather-father-son backup
  scheme. This feature can be used in conjunction with tarsnapper
  backup jobs, or standalone, to be applied to any existing set of
  tarsnap backup archives, regardless of how they have been created.

Currently I have two tarsnapper config files, one for work files and one for personal files, that are invoked via my crontab at three and seven past the hour:

~~~ crontab
# Personal
3 * * * * /bin/bash -l -c '/usr/local/bin/tarsnapper -c /Users/erebusbat/.tarsnap/tarsnapper.conf make >> /Users/erebusbat/.tarsnap/tarsnapper.log 2>&1'

# Work
7 * * * * /bin/bash -l -c '/usr/local/bin/tarsnapper -c /Users/erebusbat/.tarsnap/tarsnapper-whf.conf make >> /Users/erebusbat/.tarsnap/tarsnapper.log 2>&1'
~~~

This workflow has worked quite well for the past two days.  I am easily able to pop into one of my tarsnapper config files and tweak a backup target or even add a new one and the next hour it will be in the backup. Tarsnapper appears to be doing a good job at rotating the backups on the schedules i have defined.

## Downsides / Changes
The biggest downside so far is that tarsnapper wraps (and therefore hides) raw tarsnap output (like `--print-stats`).

The biggest change i am considering at the moment is adding a daily crontab for less volatile targets.  I have not decided if I want to add something like bi-daily, daily, weekly, etc...

At the longer ranges I am not sure the bandwidth savings would warrant the extra complexity.

I also have no automated error checking, so if I mess up a directory or tarsnapper config it might skip a whole target :(.
