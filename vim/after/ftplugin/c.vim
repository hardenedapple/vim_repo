" add a simple toggle for test scripts
nnoremap [om :set makeprg=gcc\ -Wall\ -W\ -Werror\ -g\ %\ -o\ %:r<CR>
nnoremap ]om :set makeprg=make<CR>

" Run cscope
nnoremap <F11>  :!cscope -Rb<CR> :cs reset<CR>

" add closing of comments when I type the lead
inoremap <buffer> /*  /*<Space><Space>*/<Left><Left><Left>
inoremap <buffer> /*<CR>  /*<CR><CR>/<Esc>kA 

" add opening a block with {<CR>
inoremap <buffer> {<CR>  {<CR>}<Esc>O

" This function for folding does everything I want, but slows eveything down
" in large files - If reading large files switch to foldmethod=syntax
function! FoldBrace()
    " If the line has a '{' somewhere other than the start and doesn't have a
    " '}' open new fold
    if getline(v:lnum) =~ "^\\s*[^} 	][^}]*{\\s*$"
        return 'a1'
    endif
    " If the line below starts with '{' and the current line has '}' return '='
    if getline(v:lnum+1) =~ "^\\s*{\\s*$" && getline(v:lnum) =~  "^\\s*}[^{]*$"
        return '='
    endif
    " If the line below starts with '{' increase foldlevel
    if getline(v:lnum+1) =~ "^\\s*{\\s*$"
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
" The function I've defined works nicely with pretty much all folding styles
" but is slow if there are too many folds above where you're writing.
if line('$') < 500
    set foldmethod=expr
else
    set foldmethod=syntax
endif


" Automatically add newline on ';' when outside of a comment or string

function! Semi()
    let synname = synIDattr(synID(line('.'), col('.') - 1, 1), "name")

    " If previous char is not in a Comment and Not in a string, add a newline
    if match(synname, "Comment") != -1
        return ';'
    elseif match(synname, "String") == -1
        return ';'
    endif

    " Check the number of '"' up until here - if is even, add newline
    if len(substitute(strpart(getline('.'), 0, col('.') -1), '[^"]', '','g')) % 2 == 0
        return ';'
    endif

    " In a string - return original
    return ';'
endfunction

inoremap <buffer><expr> ; Semi()
