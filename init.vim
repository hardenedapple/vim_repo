" https://github.com/neovim/neovim/issues/11066 means I can't use this.
" set all&
let g:pathogen_disabled = get(g:, 'pathogen_disabled', ['dispatch', 'easygrep'])
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
" This is just the default but with blinking turned off.
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkon0,r-cr:hor20-Cursor/lCursor-blinkon0,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
runtime vimrc
" vim: foldmethod=marker
