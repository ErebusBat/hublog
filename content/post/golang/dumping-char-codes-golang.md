+++
Categories = []
Tags = ["golang"]
date = "2015-03-08T08:07:13-06:00"
title = "Dumping Character Codes in Go"

+++
While iterating file names on my OSX system I noticed that I could not do conditional matching the the `Icon?` file, which is used to store custom icons for the Mac OSX Finder.

Turns out that OSX appends a CR (yes a carriage return) at the end of the file name.  WTF?

Anyway... I ended up with this small snippet of code to dump char codes of a string to the console that has no business remaining in the original project.
<!--more-->

~~~ go
func DumpString(str string) {
  for _, c := range str {
    fmt.Printf(">%s< %d\n", string(c), c)
  }
}
~~~

### Example

~~~ bash
$ go run main.go
>H< 72
>e< 101
>l< 108
>l< 108
>o< 111
> < 32
>W< 87
>o< 111
>r< 114
>l< 108
>d< 100
~~~


### Full Script
A full script / application example (copy paste ready).  
Assumes the file is named `dump_char_codes.go`, update static string in `log.Fatalf` call for clarity if needed.

~~~ go
package main

import (
	"fmt"
	"log"
	"os"
)

func dumpString(str string) {
	for _, c := range str {
		fmt.Printf(">%s< %d\n", string(c), c)
	}
}

func main() {
	if len(os.Args) != 2 {
		log.Fatalf("USAGE: dump_char_codes [string]")
	}
	dumpString(os.Args[1])
}
~~~
