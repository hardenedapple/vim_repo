function! airline#extensions#tabline#simple#format(bufnr, buffers)
    return fnamemodify(bufname(a:bufnr), ':t')
endfunction

let g:airline#extensions#tabline#formatter = 'simple'
