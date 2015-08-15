+++
title = "Get Wunderlist List IDs for Launch Center Pro"
date = "2015-08-06T13:02:09-06:00"
tags = ["wunderlist", "js", "launchcenterpro"]
draft = true
+++


If you use [LaunchCenter Pro](https://itunes.apple.com/us/app/launch-center-pro/id532016360?mt=8) on iOS then you know that you can create an action to open [Wunderlist](https://www.wunderlist.com/) to a specific list.  This is very useful as my wife and I use Wunderlist for shared shopping lists.
<!--more-->

There is a minor difficulty when setting up the action:  Getting the list ID.  LaunchCenter Pro's suggestion is to publish the list and then unpublished it to get the ID.  This method does not work for lists shared with you, the publish option is disabled.

However if you have access to a browser you can use this oneliner of JavaScript in your browser's console and it will output all of your lists and their corresponding ID numbers.

I used Firefox 39.0 with Firebug, but YMMV; however I would think that it should work with any modern browser console.

~~~ js
jQuery('li.list').each(function(i,e){
  e = jQuery(e);
  str = "#" + i + "\t" + e.attr('rel') + "\t" + e.attr('aria-label'); console.log(str);
})
~~~
