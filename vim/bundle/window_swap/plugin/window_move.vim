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


nnoremap <silent> <leader>H :call  DoWindowSwap('h')<CR>
nnoremap <silent> <leader>J :call  DoWindowSwap('j')<CR>
nnoremap <silent> <leader>K :call  DoWindowSwap('k')<CR>
nnoremap <silent> <leader>L :call  DoWindowSwap('l')<CR>

