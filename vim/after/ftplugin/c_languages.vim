" Filetype plugin for all C - type langagues
" should be imported by others.

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
function! CSemi()
    let colnum = col('.')
    let linenum = line('.')

    " Get current line
    let myline = getline('.')
    let prevchar = myline[len(myline) - 1]

    " Check the synID of this character
    let synlast = synIDattr(synID(linenum, colnum - 1, 1), "name")
    let synbefore = synIDattr(synID(linenum, colnum - 2, 1), "name")

    " If previous character was part of a character literal, must be complete.
    " the synID is only set once the literal has been typed.
    if synlast =~# "Character"
        return ";\n"
    "If was a comment, return ';'
    elseif synlast =~# "Comment"
        return ";"
    " If was a string, have to check for just ending
    elseif synlast =~# "String"
        if  synbefore !~# "String"
            " This is the first character in the string - the opening '"'
            return ";"
        endif
        " Now check if previous character was the last character in a string.
        if prevchar == '"'
            return ";\n"
        endif
        return ";"
    endif

    " Finally check previous character is not "'" - i.e. not writing character
    " literal
    if prevchar == "'"
        return ";"
    endif

    " Wasn't a comment, character or string.
    return ";\n"
endfunction

function! Togglenewlineadd()
    if strlen(mapcheck(';', 'i')) > 0
        iunmap <buffer> ;
    else
        inoremap <buffer><expr> ; CSemi()
    endif
endfunction

nnoremap <silent> <leader>n :call Togglenewlineadd()<CR>
