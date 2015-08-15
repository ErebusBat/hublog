+++
Categories = []
Description = ""
Tags = ["tarsnap", "field-notes"]
date = "2015-08-15T07:02:24-06:00"
title = "tarsnap field notes"

+++
My Tarsnap field notes
<!--more-->

## Tarsnap
~~~ bash
# Listing archives stored with tarsnap
$ tarsnap --list-archives | sort

# Searching for a file in a backup archive:
$ tarsnap -t -f dotfiles-20150815-120404 | grep '.tmux'
~~~

## My Specifics
These are notes that are specific to [my setup](/2015/08/two-days-with-tarsnap).

~~~ bash
# View previous backup history
$ grep -E '^(Not|Creating)' ~/.tarsnap/tarsnapper.log | tail -n 25
~~~
