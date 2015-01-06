if index(g:pathogen_disabled, 'surround') != -1
  finish
endif

" Would have this mapping on 'S', but I want the sneak plugin, and that matches
" 'S' better.
" Make 'zw' do "ysiw"
nmap zw ysiw
