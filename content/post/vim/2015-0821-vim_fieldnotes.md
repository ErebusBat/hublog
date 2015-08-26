+++
Draft = true
Tags = ["vim","field-notes"]
date = "2015-08-21T09:51:10-06:00"
title = "Vim Fieldnotes"

+++

I decided to attempt to give Vim a solid chance at being my primary editor.
<!--more-->
# Key Mapping
| Mapping              | Notes                                                                           |
| ------               | -----                                                                           |
| `:verbose imap <BS>` | Show insert mode mapping for `<BS>` (backspace) key.  Can also use `nmap`,`map` |

## Mapping Keys
~~~
:no[remap]  {lhs} {rhs}         mapmode-nvo     :no  :noremap :nor
:nn[oremap] {lhs} {rhs}         mapmode-n       :nn  :nnoremap
:vn[oremap] {lhs} {rhs}         mapmode-v       :vn  :vnoremap
:xn[oremap] {lhs} {rhs}         mapmode-x       :xn  :xnoremap
:snor[emap] {lhs} {rhs}         mapmode-s       :snor :snoremap
:ono[remap] {lhs} {rhs}         mapmode-o       :ono :onoremap
:no[remap]! {lhs} {rhs}         mapmode-ic      :no! :noremap!
:ino[remap] {lhs} {rhs}         mapmode-i       :ino :inoremap
:ln[oremap] {lhs} {rhs}         mapmode-l       :ln  :lnoremap
:cno[remap] {lhs} {rhs}         mapmode-c       :cno :cnoremap
                        Map the key sequence {lhs} to {rhs} for the modes
                        where the map command applies.  Disallow mapping of
                        {rhs}, to avoid nested and recursive mappings.  Often
                        used to redefine a command.

Examples
--------
nnoremap  <c-r> :source $MYVIMRC<CR>
~~~

# Movement
~~~
S-V	Enter Visual (line)
C-V	Enter Visual (column)
w	Forward by word
b	Backward by word
gg	Top of file
G	End of file
C-f	Move forward one screenful
C-b	Move backward one screenful
zt	Current Line on TOP of Screen
zz	Current Line in MIDDLE of Screen
zb	Current Line in BOTTOM of Screen
<S-H>	Goto HEAD of window
<S-M>	Goto MIDDLE of window
<S-L>	Goto LAST of window

t<char>	Forward 'till character (think dtX, Delete 'till next X)
T<char> Backward 'till character
f<char> Find forward and over character
F<char> Find backward and over character


~~~

# Misc
~~~
###
u	Undo
yyp	Duplicate line BELOW cursor
yyP	Duplicate line ABOVE cursor
yp	Duplicate selection BELOW cursor
yP	Duplicate selection ABOVE cursor
D	Delete until EOL
A	Insert at EOL
a	Insert after word
I	Insert at SOL
i	Insert at cursor
x	Delete under cursor
ciw	Change In Word (delete word and enter insert)
cw	Change Word (delete word from cursor and insert)
diw	Delete In Word (entire word)
dw	Delete Word (only from cursor)
dd	Delete line into default register
P	Paste register ABOVE current line
p	Paste register BELOW current line
ddkP	Move line up (dd,k,P)
:m #	Move line after # (can also be +#/-#)
<C+L>	Normal Mode: Redraw Screen, useful after a Ctrl+K or Cmd+K

~~~

# `.vimrc` settings
~~~
" Make backspace work over line breaks
set backspace=2

" Disable CodeFolding
set nofoldenable
~~~

# vim-commentary
~~~
gcc	Toggle Line Comment
gc	VISUAL: Toggle comment in visual block mode
~~~
