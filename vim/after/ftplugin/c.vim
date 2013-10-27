" add a simple toggle for test scripts
nnoremap [om :set makeprg=gcc\ -Wall\ -W\ %\ -o\ %:r<CR>
nnoremap ]om :set makeprg=make<CR>

" Run cscope
nnoremap <F11>  :!cscope -Rb<CR> :cs reset<CR>

" Run ctags (in way for OmniCppComplete)
nnoremap <F12>  :!ctags -R --fields=+iaS --extra=+q .<CR><CR>


" add closing of comments when I type the lead
inoremap <buffer> /*  /*<Space><Space>*/<Left><Left><Left>
inoremap <buffer> /*<CR>  /*<CR><CR>/<Esc>kA

" add opening a block with {<CR>
inoremap <buffer> {<CR>  {<CR>}<Esc>O


" include prototype in function folding - This uses things that the help says
" will be slow, but is a really simple function otherwise - will see when
" using large files.
function! FoldBrace()
    " If the line below starts with a '{' or this line has non-space non-'}'
    " characters before an opening bracket, increase foldlevel
    if getline(v:lnum+1) =~ "^\\s*{$" || getline(v:lnum) =~ "^\\s*[^} ][^}]*{$"
        return 'a1'
    endif
    " If the line starts with a a close bracket and doesn't have another open
    " bracket - decrease the foldlevel.
    if getline(v:lnum) =~ "^\\s*}[^{]*$"
        return 's1'
    endif
    return '='
endfunction

set foldexpr=FoldBrace()
set foldmethod=expr
