function! DoWindowSwap(direction)
    let firstWinNum = winnr()
    let firstBufNum = bufnr("%")

    " Find the next buffer
    exe "wincmd " . a:direction
    let secondWinNum = winnr()
    let secondBufNum = bufnr("%")

    " Load first buffer in this window
    exe "hide buf" firstBufNum

    "Switch focus to first window
    exe firstWinNum . "wincmd w"

    " Load second buffer in current window
    exe 'hide buf' secondBufNum

    " Go to last window
    exe secondWinNum . "wincmd w"
endfunction


nnoremap <silent> <leader>wh :call  DoWindowSwap('h')<CR>
nnoremap <silent> <leader>wj :call  DoWindowSwap('j')<CR>
nnoremap <silent> <leader>wk :call  DoWindowSwap('k')<CR>
nnoremap <silent> <leader>wl :call  DoWindowSwap('l')<CR>

