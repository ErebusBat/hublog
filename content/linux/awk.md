+++
Tags = ["linux", "field-notes", "awk"]
Description = ""
date = "2014-06-19T13:52:50-06:00"
title = "AWK Field Notes"
Aliases = ["/wiki/2014/06/19/awk.html"]
+++

#### Links
  * http://stackoverflow.com/a/6546314/3683

#### Quick
~~~ bash
# Get amount of free mem (in -m MB)
$ free -m | grep -E '^Mem' | awk '{print $4}'
$ free -m | awk '/^Mem/ {print $4}'
~~~
