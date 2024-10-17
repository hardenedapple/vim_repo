" https://github.com/neovim/neovim/issues/11066 means I can't use this.
" set all&
let g:pathogen_disabled = get(g:, 'pathogen_disabled', ['dispatch', 'easygrep',
      \ 'ctrlp', 'ctrlp-funky', 'vimple', 'vimfindsme', 'visualstar', 'commentary', 'orgmode'])
inoremap <a-O> <ESC>O
inoremap <a-o> <ESC>o
" Vimple doesn't support neovim, but so far there's only error message coming
" from it, this variable stops it.
let vimple_init_vn = 0

" This is just the default but with blinking turned off.
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkon0,r-cr:hor20-Cursor/lCursor-blinkon0,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
" Put `grepprg` back to what it is without the clever defaults added in lua.
" I know what `grep` does and the options it has, I don't know `ripgrep`
" anywhere as much.  I installed it as a dependency of some other package I
" don't want that to mean I have to learn its syntax and quirks for vim :grep
" command.
set grepprg&
set grepformat&
runtime vimrc
" vim: foldmethod=marker
