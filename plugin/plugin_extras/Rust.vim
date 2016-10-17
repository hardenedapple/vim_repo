if index(g:pathogen_disabled, 'rust-vim') != -1
  finish
endif

autocmd FileType rust compiler cargo
let g:rust_fold = 2
