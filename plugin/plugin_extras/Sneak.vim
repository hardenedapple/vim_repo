if index(g:pathogen_disabled, 'sneak') != -1
  finish
endif

" Have to switch the mappings for ; and , for my particular keyboard layout
" Can't use noremap here as it doesn't work, and I'm staying away from the
" 'langmap' option as 'langnoremap' and the like appear to be a minefield.
let g:sneak#streak = 1
let g:sneak#s_next = 0
let g:sneak#textobject_z = 0

" For Dvorak keyboard -- make closer matches on easy keys
let g:sneak#target_labels = "aoeuidhtns._pyfgcrl'qjkxbmwvzAOEUIDHTNS>-PYFGCRL\"QJKXBMWVZ"

nmap , <Plug>SneakNext
omap , <Plug>SneakNext
xmap , <Plug>SneakNext
smap , <Plug>SneakNext

nmap ; <Plug>SneakPrevious
omap ; <Plug>SneakPrevious
xmap ; <Plug>SneakPrevious
smap ; <Plug>SneakPrevious

omap u <Plug>Sneak_s
omap U <Plug>Sneak_S
