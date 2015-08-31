+++
Tags = ["syncthing","awk"]
date = "2015-08-31T14:24:33-06:00"
title = "Create CSV of SyncThing Device/ID pairs"

+++

How to extract SyncThing Device ID / Name pairs from syncthing log file.
<!--more-->
I was setting up a [SyncThing](http://www.syncthing.org) (v0.11.23) cluster this morning and needed a list of my device IDs / names.  Looking at my SyncThing log it was fairly easy to whip up this oneliner:

~~~ bash
grep "name is" /usr/local/var/log/syncthing.log | awk '{print "\"" $5 "\"" "," $8}' | sort -u
~~~

This is very primitive so it will output a line for each id/name it sees, even if the ID has been seen before, which may or may not be what you want.

I am no `awk` super wizz so I am sure there is a better way to output quoted strings, but this worked.
