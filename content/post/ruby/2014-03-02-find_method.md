+++
# Original file converted from DokuWiki on 2015-07-01T16:26:19-06:00:
#    /data/opt/wiki/data/pages/ror/find_method.txt
title = "Find Method at Runtime"
date  = "2014-03-02T22:42:40-06:00"
tags  = ["DokuWiki","ruby"]
+++

How to find the source location of a Ruby method at runtime.
<!--more-->

Taken from the [Stack Overflow][4] answer by [wesgarrison](http://stackoverflow.com/users/62140/).

I take no credit for the work.

--------------------------------------------------------------------------------

~~~ ruby
# How to find out where a method comes from.
# Learned this from Dave Thomas while teaching Advanced Ruby Studio
# Makes the case for separating method definitions into
# modules, especially when enhancing built-in classes.
module Perpetrator
  def crime
  end
end

class Fixnum
  include Perpetrator
end

p 2.method(:crime)
#<Method: Fixnum(Perpetrator)#crime>
~~~

If you're on Ruby 1.9+, you can use [`source_location`][1]

~~~ ruby
require 'csv'

p CSV.new('string').method(:flock)
# => #<Method: CSV#flock>

CSV.new('string').method(:flock).source_location
# => ["/path/to/ruby/1.9.2-p290/lib/ruby/1.9.1/forwardable.rb", 180]
~~~

Note that this won't work on everything, like native compiled code. The [Method class][2] has some neat functions, too, like [Method#owner][3] which returns the file where the method is defined.

EDIT: Also see the `__file__` and `__line__` and notes for REE in the other answer, they're handy too. -- wg


[1]: http://www.ruby-doc.org/core-1.9.3/Method.html#method-i-source_location
[2]: http://www.ruby-doc.org/core-1.9.3/Method.html
[3]: http://www.ruby-doc.org/core-1.9.3/Method.html#method-i-owner
[4]: http://stackoverflow.com/questions/175655/how-to-find-where-a-method-is-defined-at-runtime
[5]: http://gist.github.com/76951
