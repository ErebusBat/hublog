+++
title = "Install TinyTDS Gem on OSX 10.10 Yosemite"
Tags = ["ruby", "rails"]
date = "2015-08-04T13:29:12-06:00"

+++

There are a couple of [howtos](http://stackoverflow.com/questions/26613673/error-installing-tiny-tds-on-osx-10-10-yosemite) out there on how to fix the dreaded **ERROR: Failed to build gem native extension.** when running `gem install tiny_tds`.

This one will fix it without having to force link `libiconv` which is not a good thing to do.
<!--more-->

### Prerequisites

First you want to make sure that you have `freetds` and `libiconv` installed in [Homebrew](http://brew.sh/).  I already had these installed so YMMV on this step:

~~~ bash
brew install libiconv
brew install freetds
~~~

It is normal for `libiconv` to complain that it is keg only, that is the whole point.

### Install tiny_tds

Now it is just a simply matter of telling `gem install` where `libiconv` and `freetds` are located.

~~~ bash
$ gem install tiny_tds -- --with-iconv-dir=$(brew --prefix libiconv) \
  --with-freetds-dir=$(brew --prefix freetds)
Building native extensions.  This could take a while...
Successfully installed tiny_tds-0.6.2
1 gem installed
~~~

**IMPORTANT**: Do _not_ forget the double hyphen (`--`) between the gem install
command and the options.
