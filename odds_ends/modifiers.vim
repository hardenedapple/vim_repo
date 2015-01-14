"------------------      Add modifiers to VFMArgument --------------------
"
" All credit to bairui/dahu -- gave this as the answer to a question I asked on
" freenode #vim 
let s:cmdmod = ''

function! GetCmdMod()
let cmdmod = s:cmdmod
let s:cmdmod = ''
return cmdmod
endfunction

function! CmdMod(mod)
let cmdline = getcmdline()
if getcmdpos() != 1
return cmdline
else
let s:cmdmod = a:mod
return a:mod . cmdline
endif
endfunction

cabbrev vert <c-\>eCmdMod('vert')<cr>
cabbrev topleft <c-\>eCmdMod('topleft')<cr>

command! Foo echo 'I was called with #' . GetCmdMod() . '#'

