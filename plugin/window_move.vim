function! s:MoveWindow(direction)
    let firstPosis = getpos('.')
    let firstWinNum = winnr()
    let firstBufNum = bufnr("%")
    " Find the next buffer
    exe "wincmd " . a:direction
    let secondPosis = getpos('.')
    let secondWinNum = winnr()
    let secondBufNum = bufnr("%")
    " Load first buffer in this window
    exe "hide buf" firstBufNum
    "Switch focus to first window
    exe firstWinNum . "wincmd w"
    " Load second buffer in current window
    exe 'hide buf' secondBufNum
    call setpos('.', secondPosis)
    " Go to last window
    exe secondWinNum . "wincmd w"
    call setpos('.', firstPosis)
endfunction


nnoremap <silent> <leader>wh :call  <SID>MoveWindow('h')<CR>
nnoremap <silent> <leader>wj :call  <SID>MoveWindow('j')<CR>
nnoremap <silent> <leader>wk :call  <SID>MoveWindow('k')<CR>
nnoremap <silent> <leader>wl :call  <SID>MoveWindow('l')<CR>

