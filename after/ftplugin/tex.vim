"Probable only work on writing at work (on big screen)
" Turns out, now I've left uni, writing LaTeX is done on my laptop, and I hate
" this alternate textwidth.
" (I should have guessed that really)
" setlocal textwidth=125

setlocal shiftwidth=2
setlocal iskeyword+=:,_

setlocal wildignore-=*.png,*.jpg,*.gif
"Change the colorscheme to one better for tex
if has('gui_running')
    colorscheme autumn
endif

set makeprg=pdflatex\ -interaction\ nonstopmode\ %
nnoremap [om :set makeprg=pdflatex\ %<CR>
nnoremap ]om :set makeprg=make<CR>

lnoremap <buffer> [ {
lnoremap <buffer> ] }
lnoremap <buffer> { [
lnoremap <buffer> } ]
lnoremap <buffer> : ;
lnoremap <buffer> ; :
