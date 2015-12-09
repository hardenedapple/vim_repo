if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.vsh    setfiletype vsh
augroup END
