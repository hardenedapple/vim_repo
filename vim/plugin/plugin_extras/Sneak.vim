" Have to switch the mappings for ; and , for my particular keyboard layout
" Can't use noremap here, doesn't work.
let g:sneak#streak = 1
let g:sneak#s_next = 1
let g:sneak#textobject_z = 0


nmap , <Plug>SneakNext
omap , <Plug>SneakNext
xmap , <Plug>SneakNext
smap , <Plug>SneakNext

nmap ; <Plug>SneakPrevious
omap ; <Plug>SneakPrevious
xmap ; <Plug>SneakPrevious
smap ; <Plug>SneakPrevious