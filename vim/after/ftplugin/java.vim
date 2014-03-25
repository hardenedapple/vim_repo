set foldmethod=syntax

" add a simple toggle for test scripts
nnoremap [om :set makeprg=javac\ %<CR>
nnoremap ]om :set makeprg=make<CR>

" add closing of comments when I type the lead
inoremap <buffer> /*  /*<Space><Space>*/<Left><Left><Left>
inoremap <buffer> /*<CR>  /*<CR><CR>/<Esc>kA 

" add opening a block with {<CR>
inoremap <buffer> {<CR>  {<CR>}<Esc>O

