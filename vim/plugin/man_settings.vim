runtime ftplugin/man.vim

" Change the man command.
function! OpenManThisWindow(man_page)
    exe "Man " . a:man_page
    exe "wincmd k"
    let newWindow = winnr()
    close
    exe newWindow . "wincmd w"
endfunction

function! OpenManVerticalSplit(man_page)
    exe "wincmd v"
    call OpenManThisWindow(a:man_page)
endfunction

" This might be annoying if the keywordprg  is set elsewhere, so add a mapping
" to toggle it.
function! ToggleManSetting()
    if strlen(mapcheck('K', 'n')) > 0
        unmap <buffer> K
    else
        nnoremap <buffer> K :call OpenManThisWindow(expand("<cword>"))<CR>
    endif
endfunction

nnoremap <silent> <LocalLeader>mo :call ToggleManSetting()<CR>
nnoremap <buffer> K :call OpenManThisWindow(expand("<cword>"))<CR>

command! -bar -nargs=? VMan call OpenManVerticalSplit(<f-args>)
