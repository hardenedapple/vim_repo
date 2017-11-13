if !has('nvim')
  runtime ftplugin/man.vim
endif

" Man command has special account for the '<cword>' argument
" (expands it itself -- so there's no reason to expand it here)

function s:OpenManThisWindow(man_page)
  " If we start off in a man page, don't want to remove previous window
  " We can't tell by checking anything to do with the current buffer, because
  " if a man page is open in another window the then :Man will show the new
  " page in that window, moving us there.
  "
  " The only real way to tell if we've opened another window is to count the
  " number of windows before and after.
  let window_count = winnr('$')
  let curwin = winnr()
  exe "Man " . a:man_page
  if window_count == winnr('$')
    return 1
  endif

  " Close the window that we were in before this new one was opened.
  " n.b. I had  `wincmd k`, `close`, 'wincmd p` before.
  " I don't know if that was for any reason ... I've changed it to this because
  " it looks like it will be neater and not mess around with any convenience
  " variables.
  exe curwin . 'close'
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
" to change it.
function s:UseVimForMan()
  if has('nvim')
    nnoremap <buffer> <silent> K :<C-U>call <SID>OpenManThisWindow("<C-R>=expand("<cword>")<CR>")<CR>
  else
    nnoremap <buffer> <silent> K :<C-U>call <SID>OpenManThisWindow("<cword>")<CR>
  endif
endfunction

nnoremap <silent> [ok :<C-U>call <SID>UseVimForMan()<CR>
nnoremap <silent> ]ok :<C-U>unmap <buffer> K<CR>

call s:UseVimForMan()

if has('nvim')
  command -bar -nargs=+ VMan exe 'vert Man ' . <q-args>
else
  command -bar -nargs=+ VMan call s:OpenManVerticalSplit(<q-args>)
endif
