" Search for a certain tag, save all the results as a quickfix list.

let s:kind_tag_dict = {
      \ 'd' : 'define',
      \ 'f' : 'function',
      \ 'm' : 'member',
      \ 'c' : 'class',
      \ 'v' : 'variable',
      \ 'F' : 'file',
      \ 's' : 'struct',
      \ 't' : 'typedef',
      \ 'e' : 'enumerator',
      \ 'g' : 'enum',
      \ 'n' : 'namespace',
      \ 'p' : 'property',
      \ 'u' : 'union',
      \ 'l' : 'label',
      \ }

function s:convert_entry(entry)
  let entry = a:entry
  if !str2nr(entry.cmd)
    let entry.pattern = '\M' . entry.cmd[1:-2]
  else
    let entry.lnum = str2nr(entry.cmd)
  endif
  let entry.filename = entry.filename
  if entry.kind != ''
    " Can have single letter kinds or full names depending on `cflags` option
    " --fields=+k or --fields=+K
    if len(entry.kind) == 1
      let kind_text = get(s:kind_tag_dict, entry.kind, 'unknown tag-kind "' . entry.kind . '"')
    else
      let kind_text = entry.kind
    endif
    let entry.text = kind_text . ':	' . entry.name
  else
    let entry.text = entry.name
  endif
  unlet entry.name entry.kind entry.cmd
  return entry
endfunction

" This function exposes the functionality of converting a taglist into a
" quickfix list.
" This is useful when manually examining large taglist returns (e.g. there's a
" lot of functions with the same name because of C++).
function TQFSetQuickfix(taglist)
  call setqflist(map(a:taglist, { index, value -> s:convert_entry(value) }))
endfunction

function s:TagSelectToQuickfix(pattern)
  let availableTags = taglist(a:pattern)
  call TQFSetQuickfix(availableTags)
  call helpers#open_list_unobtrusively('', 'copen')
endfunction

command -bar -nargs=1 TQFSelect call s:TagSelectToQuickfix(<q-args>)

nnoremap <leader>st :<C-U>silent TQFSelect! <C-R><C-W><CR>
nnoremap t<RightMouse> <LeftMouse>:<C-U>silent TQFSelect <C-R><C-W><CR>
nnoremap T<RightMouse> <LeftMouse>:<C-U>silent TQFSelect! <C-R><C-W><CR>
