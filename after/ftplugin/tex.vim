"Probable only work on writing at work (on big screen)
setlocal textwidth=125

setlocal shiftwidth=2
setlocal iskeyword+=:

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