+++
date = "2015-03-04"
title = "Embed SASS in HAML"
tags = ["sass", "haml"]
+++

Sometimes it is necessary to add CSS styling tags directly into HAML content.  I am forever forgetting the proper way to do this.

~~~ haml
%style{type:'text/css'}
  :sass
    .bundle_logo
      background: url(logo.jpg) no-repeat scroll left top transparent
      height: 133px
      width: 128px
~~~
