" Add /usr/include/ to the path variable
set path^=/usr/include

" add a simple toggle for test scripts
nnoremap <buffer> [om :<C-U>set makeprg=gcc\ -Wall\ -W\ -g\ %\ -o\ %:r<CR>
if g:os == 'SunOS'
  nnoremap <buffer> ]om :<C-U>set makeprg=gmake<CR>
else
  " Currently assuming GNU make is the default on all non-Sun systems.
  " This will probably be incorrect, but it's better than guessing all systems
  " that don't have GNU make as the default will have it named gmake instead.
  nnoremap <buffer> ]om :<C-U>set makeprg=make<CR>
endif

" Run cscope
nnoremap <F11>  :<C-U>!cscope -Rb<CR>:cs reset<CR>

if g:working_on_solaris
  setlocal noexpandtab
  setlocal shiftwidth=8
  setlocal tabstop=8
  setlocal cinoptions=t0,+4,(4,u0,U0,W4
endif
