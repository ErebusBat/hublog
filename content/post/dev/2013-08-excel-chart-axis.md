+++
# Original file converted from DokuWiki on 2015-03-06T18:13:15-07:00:
#    /data/opt/wiki/data/pages/excel/vba.txt
title = "Hide/Unhide Chart Axis"
date = "2013-08-09T19:02:12-06:00"
tags =["excel", "DokuWiki"]
+++

## Hide/Unhide Chart Axis

~~~ vbnet
'// This takes a sheet name, where it is a chart sheet.
'// If your chart lives on a regular worksheet then you will probably need to add a call to Sheet.ChartObject("chart name")
Function ToggleChartAxisValues(sheetName As String)
    Dim c As Chart, isHidden As Boolean, ax As Axis
    Set c = Sheets(sheetName)
    Set ax = c.Axes(xlValue)
    isHidden = (ax.TickLabelPosition = xlTickLabelPositionNone)

    If isHidden Then
        '// Unhide
        ax.TickLabelPosition = xlTickLabelPositionNextToAxis
    Else
        '// Hide
        ax.TickLabelPosition = xlTickLabelPositionNone
    End If
End Function
~~~
