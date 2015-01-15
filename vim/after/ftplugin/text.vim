"Automatically save and load view for text files -- mainly for folding.
if bufname("%") != ""
  augroup temp_view_group
    autocmd BufWinEnter <buffer> call ftplugin_helpers#text#create_view_autocmds()
  augroup END
endif

" I want this to only work on files that have a filename associated with them,
" and that are text files.
"
" The fact this is in the text ftplugin should accomplish the second,
