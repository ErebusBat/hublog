+++
# Original file converted from DokuWiki on 2015-03-06T18:13:15-07:00:
#    /data/opt/wiki/data/pages/excel/dates.txt
title = "Convert to Excel Time from Unix Time"
date = "2013-08-08T18:50:09-06:00"
tags = ["excel", "DokuWiki"]
+++

**UnixTime**
~~~
ExcelTime = (UnixTime + ("1/1/1970"-"1/1/1900"+1)*86400) / 86400
~~~
