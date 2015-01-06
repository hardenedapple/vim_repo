if index(g:pathogen_disabled, 'python-mode') != -1
  finish
endif

" Python-mode plugin

" These variables don't matter if don't have python-mode installed

let g:pymode_options = 0
let g:pymode_folding = 1
let g:pymode_lint_checker = "pylint,pyflakes,pep8,mccabe"
let g:pymode_lint_cwindow = 1
" let g:pymode_lint_message = 0
" don't automatically call checking - same reason as for syntastic
" don't highlight spaces at end of line - when typing is annoying
let g:pymode_lint_on_write = 0
let g:pymode_syntax_space_errors=0

let g:pymode_run_key='<leader>pr'

"Disable ropevim in favour of jedi vim
let g:pymode_rope=0
" let g:pymode_rope_extended_complete=1
" let g:pymode_rope_enable_autoimport=1

let g:pymode_run=0
" map pk to run pymode lint
nnoremap <leader>pk :PymodeLint<CR>
