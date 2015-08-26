+++
Tags = ["tmux","vim"]
date = "2015-08-26T09:42:56-06:00"
title = "TMUX Login Wrapper Script"

+++

After watching a [talk on Vim & TMUX](https://www.youtube.com/watch?v=5r6yzFEXajQ) by [Nick Nisi](https://github.com/nicknisi) I was inspired to improve on his [tm script](https://github.com/nicknisi/dotfiles/blob/master/bin/tm).

Like Nick's original, my script allows me to easily attach to running tmux sessions and create ad hoc new onces. I then added the ability to list any [tmuxinator](https://github.com/tmuxinator/tmuxinator) configurations I have. 
<!--more-->
I wanted a workflow where I could easily connect to existing tmux sessions, which Nick's script did great.  However I am already a heavy Tmuxinator user and have several pre-defined configurations (as you can see).

In the example gif video below you can see the general idea in action (forgive the horrid colors, that is another issue I am working on):

![gif](/img/2015/201508-tmlogin.gif)

# Login Shell
I did set this up as my login shell, why?  Well with my current ZSH config it can take a second or two for my prompt to load.  I haven't had time to track down why that is happening.  After my sessions are loaded then I am not spinning up that many shells.  

However waiting on my slow shell session startup just to turn around and launch tmux to launch more ZSH seemed like a waste. By setting `tmlogin` as my login shell it spins up instantly. 

This did cause some minor problems, given that `tmlogin` is really not a shell.  Exporting my real shell in `tmlogin` seems to have fixed that.

If you find it useful then please drop me a line, it is dirty and hacked together, but it works.

You can view [the gist here](https://gist.github.com/ErebusBat/dacc0bcd92d7aa1494f1).
