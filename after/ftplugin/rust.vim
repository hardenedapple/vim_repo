runtime! ftplugin/c_languages.vim

" The rust-vim plugin I've downloaded changes this, and doesn't provide any way
" to cleanly tell it to stop. Hence I have to put this setting here (despite
" that not fitting my organisation of plugin settings get put in the
" plugin_extras/ file.
setlocal formatoptions+=t

" add a simple toggle for test scripts
nnoremap <buffer> [om :<C-U>set makeprg=rustc\ -g\ %\ -o\ %:r<CR>
nnoremap <buffer> ]om :<C-U>set makeprg=cargo<CR>
