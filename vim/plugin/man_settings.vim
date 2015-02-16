runtime ftplugin/man.vim

" Man command has special account for the '<cword>' argument
" (expands it itself -- so there's no reason to expand it here)

function s:OpenManThisWindow(man_page)
    " If we start off in a man page, don't want to remove previous window
    if &filetype == "man"
        let close_prev = 0
    else
        let close_prev = 1
    endif
    let current_buffer = bufnr('%')
    exe "Man " . a:man_page
    if current_buffer == bufnr('%')
      return 1
    endif
    if close_prev
        exe "wincmd k"
        close
        exe "wincmd p"
    endif
endfunction

" Doesn't actually have to be a single argument, passing the string '2 write'
" will look in section '2' for a 'write' entry
function s:OpenManVerticalSplit(man_page)
    vsplit
    if s:OpenManThisWindow(a:man_page)
      close
    endif
endfunction

" This might be annoying if the keywordprg  is set elsewhere, so add a mapping
" to toggle it.
function s:ToggleManSetting()
    if strlen(mapcheck('K', 'n')) > 0
        unmap <buffer> K
    else
        nnoremap <buffer> K :call <SID>OpenManThisWindow("<cword>")<CR>
    endif
endfunction

nnoremap <silent> <LocalLeader>mo :call <SID>ToggleManSetting()<CR>
nnoremap <buffer> K :call <SID>OpenManThisWindow("<cword>")<CR>

command -bar -nargs=+ VMan call s:OpenManVerticalSplit(<q-args>)
