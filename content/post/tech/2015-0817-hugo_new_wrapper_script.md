+++
Tags = ["hugo"]
date = "2015-08-17T09:14:59-06:00"
title = "Simple Wrapper around `hugo new`"

+++

I am slightly anal about how my files are structured on disk.  To this end I like to date prefix my post files.  [Hugo](http://hugo.io) does not easily accommodate this and I found that it was causing me to not write blog posts or quick notes when I otherwise would have.
<!--more-->
To fix the issue I wrote a small little script: [newpost.zsh](https://github.com/ErebusBat/hublog/blob/e5c75ad4336a1f82443c7ece56f18d44eed0ba9b/script/newpost.zsh).  I can either call it as a one off, or from a `make new` to easily kick off new posts.

It does require ZSH as I am using some of the nifty [parameter expansion](http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion) that is unique to ZSH.

Here is an example of a `make new` run, and the resulting output:

~~~ bash
$ make new
ASK=1 script/newpost.zsh
TITLE: Hello World

Listing existing post paths:
content
└── post
    ├── apple
    ├── dev
    ├── ffmpeg
    ├── fieldnotes
    ├── golang
    ├── linux
    ├── mssql
    ├── mysql
    ├── pgsql
    ├── rails
    ├── ruby
    └── tech

13 directories
PATH: dev
hugo new post/dev/2015-0817-hello_world.md
/data/src/hublog/content/post/dev/2015-0817-hello_world.md created

$ cat /data/src/hublog/content/post/dev/2015-0817-hello_world.md
+++
Draft = true
Tags = [""]
date = "2015-08-17T09:24:01-06:00"
title = "2015 0817 hello_world"

+++

DO NOT FORGET TO FIX THE TITLE ABOVE

AboveFold
<!--more-->
BelowFold
~~~

As you can see from the output (specificly `title` in the post frontmatter) it isn't a silver bullet; however it is MUCH easier to remove a date string and type a post title than it is with the inverse.
