set all&
let g:pathogen_disabled = get(g:, 'pathogen_disabled', ['clang_complete', 'dispatch'])
" Set an environment variable to use the t_SI/t_EI hack
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
inoremap <a-O> <ESC>O
inoremap <a-o> <ESC>o
" Vimple doesn't support neovim, but so far there's only error message coming
" from it, this variable stops it.
let vimple_init_vn = 0
runtime vimrc
" vim: foldmethod=marker
