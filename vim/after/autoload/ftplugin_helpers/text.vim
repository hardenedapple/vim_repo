function ftplugin_helpers#text#create_view_autocmds()
  autocmd! temp_view_group
  if &filetype == 'text'
    silent loadview
    autocmd BufWritePost <buffer> mkview
  endif
endfunction
