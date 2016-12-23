set all&
let g:pathogen_disabled = get(g:, 'pathogen_disabled', ['clang_complete', 'dispatch'])
" Set an environment variable to use the t_SI/t_EI hack
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
inoremap <a-O> <ESC>O
inoremap <a-o> <ESC>o
" Vimple doesn't support neovim, but so far there's only error message coming
" from it, this variable stops it.
let vimple_init_vn = 0

" I prefer having linewise % operation to being able to move within extra
" matching pairs at the moment.
" When issue #5691 is fixed, I'll remove the line below.
" https://github.com/neovim/neovim/issues/5691
let loaded_matchit = 1
runtime vimrc
" vim: foldmethod=marker
