set all&
let g:pathogen_disabled = get(g:, 'pathogen_disabled', ['clang_complete', 'dispatch'])
" Set an environment variable to use the t_SI/t_EI hack
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
imap <a-O> <ESC>O
imap <a-o> <ESC>o
runtime vimrc
" vim: foldmethod=marker
