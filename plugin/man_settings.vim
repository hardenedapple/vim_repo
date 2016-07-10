runtime ftplugin/man.vim

" Can't do the alternate position man pages with neovim.
" Instead neovim opens up the man page in a new tab.
if has('nvim')
  set keywordprg=:Man
  finish
endif

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
" to change it.
function s:UseVimForMan()
  nnoremap <buffer> K :call <SID>OpenManThisWindow("<cword>")<CR>
  " To get this command to work in neovim (not that I ever use it in neovim),
  " you need the following instead.
  " nnoremap <buffer> K :call <SID>OpenManThisWindow("<C-R>=expand("<cword>")<CR>")<CR>
endfunction

nnoremap <silent> [om :call <SID>UseVimForMan()<CR>
nnoremap <silent> ]om :unmap <buffer> K<CR>

nnoremap <buffer> K :call <SID>OpenManThisWindow("<cword>")<CR>
  " To get this command to work in neovim (not that I ever use it in neovim),
  " you need the following instead.
  " nnoremap <buffer> K :call <SID>OpenManThisWindow("<C-R>=expand("<cword>")<CR>")<CR>

command -bar -nargs=+ VMan call s:OpenManVerticalSplit(<q-args>)
