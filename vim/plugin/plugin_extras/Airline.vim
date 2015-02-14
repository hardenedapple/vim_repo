if index(g:pathogen_disabled, 'airline') != -1
  finish
endif

" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}\ \ \ %{SyntasticStatuslineFlag()}%=%-14.(%l,%c%V%)\ %P
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
" Have to put this option in the after/autoload directory so everything loads
" properly
" let g:airline#extensions#tabline#formatter = 'simple'

" This is set for ctrlspace, If I ever remove that plugin, can set this option
" to 1
let g:airline_exclude_preview = 1
