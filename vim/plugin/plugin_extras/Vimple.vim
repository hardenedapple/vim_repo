if index(g:pathogen_disabled, 'vimple') != -1
  finish
endif

" Remap some vimple mappings
nmap <silent> <leader>mu <Plug>VimpleMRU
nmap <unique><silent> <leader>ll <plug>vimple_filter

" Remove the mappings I don't want from vimple.
nmap <plug>remove_vimple_tag_search <plug>vimple_tag_search
nmap <plug>remove_vimple_spell_suggest <plug>vimple_spell_suggest
imap <plug>remove_vimple_completers_trigger <plug>vimple_completers_trigger
nmap <plug>remove_vimple_ident_search <plug>vimple_ident_search
nmap <plug>remove_vimple_ident_search_forward <plug>vimple_ident_search_forward

function s:put_into_buffer(to_put, position) range
  let current_buffer = bufname('%')
  execute 'keepa buffer ' . a:to_put
  normal zn
  execute a:position . 'ReadIntoBuffer ' . current_buffer . ' ' . a:firstline . ' ' . a:lastline
  execute 'keepa buffer ' . current_buffer
endfunction

command -nargs=+ -complete=buffer -range PutIntoBuffer :<line1>,<line2>call s:put_into_buffer(<f-args>)
