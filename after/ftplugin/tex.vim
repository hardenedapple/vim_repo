"Probable only work on writing at work (on big screen)
" Turns out, now I've left uni, writing LaTeX is done on my laptop, and I hate
" this alternate textwidth.
" (I should have guessed that really)
" setlocal textwidth=125

setlocal shiftwidth=2
" Because vim sets the default 'iskeyword' in the syntax file rather than the
" ftplugin file, having a 'set' command changing it here gets overridden.
" Instead there's a global variable we can use to ask the syntax file to set
" 'iskeyword' how I like it.
" Unfortunately, setting a global variable in a ftplugin file means
" re-assigning it every time I open a new LaTeX buffer, but I choose that over
" putting filetype specific information in a global initialisation file.
" setlocal iskeyword+=:,_
let g:tex_isk="48-57,a-z,A-Z,192-255,:,_"

setlocal wildignore-=*.png,*.jpg,*.gif
"Change the colorscheme to one better for tex
if has('gui_running')
  colorscheme autumn
endif

set makeprg=pdflatex\ -interaction\ nonstopmode\ %
nnoremap [om :<C-U>set makeprg=pdflatex\ %<CR>
nnoremap ]om :<C-U>set makeprg=make<CR>

lnoremap <buffer> [ {
lnoremap <buffer> ] }
lnoremap <buffer> { [
lnoremap <buffer> } ]
lnoremap <buffer> : ;
lnoremap <buffer> ; :
