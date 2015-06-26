+++
date = "2012-09-04T16:17:49-06:00"
title = "ZSH Field Notes"
tags = ["zsh", "field-notes", "DokuWiki"]
aliases = ["/wiki/2012/09/04/zsh.html"]
+++

Misc notes and snippets in a _Field Notes_ style
<!--more-->


## Links
  * [ZSH Conditional Expressions](http://www.cs.elte.hu/zsh-manual/zsh_12.html)
  * http://zanshin.net/2013/09/03/how-to-use-homebrew-zsh-instead-of-max-os-x-default/
  * [ Some basic but good generic linux docs](http://linux-training.be/files/books/html/fun/index.html )

------------------------------------------------------------------------
### Path Expansion

~~~ bash
#!/usr/bin/zsh
# test script
theVar='/bin/path/file.txt'
echo ${theVar:e}    # txt
echo ${theVar:t}    # file.txt
echo ${theVar:r}    # /bin/path/file
echo ${theVar:h}    # /bin/path
echo ${theVar:h:h}  # /bin
echo ${theVar:t:r}  # file
~~~

| Flag |                                     Description                                        |
|------|----------------------------------------------------------------------------------------|
| h    | Remove a trailing pathname component, leaving the head.  This works like `dirname'.    |
| r    | Remove a filename extension of the form `.XXX', leaving the root name.                 |
| e    | Remove all but the extension.                                                          |
| t    | Remove all leading pathname components, leaving the tail.  This works like `basename'. |


------------------------------------------------------------------------
### Loops
~~~ bash
# WHILE - Simple watch
while (sleep 60) do; clear; ./command; done
# FOR - Every file
for f in *.m4v; do mvmedia $f; done
for f in *.{html,sass}; do echo $f; done
~~~


~~~ bash
# Dump MySQL table 'contents' into development, every M5 /w messages
while (true) do;
  echo "Dumping $(date)...";
  ssh prodsrv "mysqldump database_production contents" | mysql database_development;
  echo "    done";
  sleep 300;
done
~~~


~~~ bash
# Very simple benchmark
for i in {1..5}; do time echo 'exit' | rails c production; done
for i in {1..5}; do time rake -T > /dev/null; done
~~~

~~~ bash
# Process a subset of zero padded files, like D02S00.  03-13 in this example:
for s in `seq -f "%02g" 3 13`; do \
  task1.rb "IMG.D02S${s}.mkv" && \
  task2 "IMG.D02S${s}.m4v"; done
~~~

------------------------------------------------------------------------
### Regular Expressions Regex
~~~ bash
ITEMS=(
  Desktop
  Pictures
  Backups
)
# Allow specifying items to select as $1, separated by a space (/ /),
if [[ ! -z $1 ]]; then
  # This will become an array
  SPECIFIED_ITEMS=("${(s/ /)1}")
  for i in $SPECIFIED_ITEMS; do
    # This syntax will remove the extension (r), then check the ITEMS
    # collection to get the index ($i), -1 if not found
    if [[ ${${ITEMS[(r)$i]}:--1} == "-1" ]]; then
      echo "*** ERROR: $i is not a valid item! Valid items are: $ITEMS"
      exit 1
    else
      # OK
    fi
  done
  ITEMS=$SPECIFIED_ITEMS
fi
~~~

------------------------------------------------------------------------
### Arrays
~~~ bash
# Allow specifying items to override as $1, separated by a space (/ /),
# check to make sure that said items are valid (appear in the ITEMS list).
URLS=(
  Desktop
  Pictures
  Backups
)

# Loop
for f in $URLS; do
  wget $f
done
~~~


------------------------------------------------------------------------
### Hotkeys
  * https://coderwall.com/p/a8uxma
  * http://www.geekmind.net/2011/01/shortcuts-to-improve-your-bash-zsh.html


------------------------------------------------------------------------
### History
http://stackoverflow.com/questions/9502274/last-command-in-same-terminal

~~~ bash
# Don't share history between sessions
setopt no_share_history

# Share history between sessions
setopt share_history
~~~

------------------------------------------------------------------------
### Passing Arguments to App
Below is a wrapper script that sources [[rbenv]] and passes ALL arguments (correctly) to the ruby script.

~~~ bash
#!/bin/zsh
export HOME=/Users/aburns
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
cd $HOME/bin/1.9.3
# echo -E ${(q)@}
ruby ./myIL.rb ${(Q)@}
~~~
