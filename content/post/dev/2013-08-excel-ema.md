+++
title = "Calculating EMA in Excel"
date =  "2013-08-08T20:13:07-06:00"
tags =["excel", "DokuWiki"]
+++


#### Exponential Moving Average
  * http://www.willowsolutions.com/tips/tips_2002_11.shtml
  * http://www.willowsolutions.com/tips/tips_2002_11_1.shtml
  * http://www.aaii.com/computerizedinvesting/article/spreadsheet-corner-constructing-moving-averages


A simple moving average calculates the average price for a set number of time periods. To calculate a 10 day moving average you would calculate the sum of the closing price for a period of 10 days and divide by 10. On the eleventh day you would add the price for the eleventh day to the average and subtract the price for the first day.

The formula used to calculate an EMA uses a smoothing constant. The smoothing constant applies the appropriate weighting for the most recent price relative to the previous day’s EMA calculation.

~~~
EMA=(Today’s Last – Yesterday’s EMA) x (SmoothingConstant) + Yesterday’s EMA

# N=EMA Periods
SmoothingConstant = 2 / (1 + N)
~~~
