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

let s:project = helpers#working_environment(1)
if s:project == 'solaris'
  setlocal noexpandtab
  setlocal shiftwidth=8
  setlocal tabstop=8
  setlocal cinoptions=t0,+4,(4,u0,U0,W4
elseif s:project == 'gnu'
  " Coding standards taken from https://gcc.gnu.org/wiki/FormattingCodeForGCC
  setlocal noexpandtab
  setlocal shiftwidth=2
  setlocal tabstop=8
  setlocal softtabstop=2
  setlocal formatoptions-=ro
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
elseif s:project == 'vim'
  setlocal shiftwidth=2
  setlocal tabstop=2
  setlocal softtabstop=2
endif
