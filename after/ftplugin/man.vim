if !has('nvim')
  " These settings are already done in nvim.
  " I recognise that this doesn't actually matter, but I want it clear when
  " reading the configuration that these settings are only needed for vim.
  " That way, if I happen to notice that vim has stopped needing these, or I
  " stop using vim at all in favour of neovim, then I know I can remove these.
  setlocal nonumber
  setlocal ts=8
  setlocal nomodified
  setlocal nolist
  setlocal nomodifiable
endif
lnoremap <buffer> - -
lnoremap <buffer> _ _
lnoremap <buffer> ; :
lnoremap <buffer> : ;

" I don't like 'q' closing the buffer.
" I can close the buffer myself perfectly fine, and with 'q' mapped, then I
" can't use macros when copying information across from the man page into other
" buffers.
nunmap <buffer> q
