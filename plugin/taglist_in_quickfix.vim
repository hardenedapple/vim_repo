" Search for a certain tag, save all the results as a quickfix list.

let s:kind_tag_dict = {
      \ 'd' : 'define',
      \ 'f' : 'function',
      \ 'm' : 'member',
      \ 'c' : 'class',
      \ 'v' : 'variable',
      \ 'F' : 'file',
      \ 's' : 'struct',
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
    let entry.text = get(s:kind_tag_dict, entry.kind, 'unknown tag-kind "' . entry.kind . '"') . ':	' . entry.name
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
  call setqflist(map(taglist, { index, value -> s:convert_entry(value) }))
endfunction

function s:TagSelectToQuickfix(pattern, bang)
  let pattern = empty(a:pattern) ? '.' : a:pattern
  let availableTags = taglist(pattern)
  if a:bang != '' && a:pattern != ''
    let availableTags = filter(availableTags, 'v:val["name"] == "' . a:pattern . '"')
  endif
  call setqflist(map(availableTags, 's:convert_entry(v:val)'))
  call helpers#open_list_unobtrusively('', 'copen')
  copen
endfunction

command -bang -bar -nargs=? TQFSelect call s:TagSelectToQuickfix(<q-args>, '<bang>')

nnoremap <leader>st :<C-U>silent TQFSelect! <C-R><C-W><CR>
nnoremap t<RightMouse> <LeftMouse>:<C-U>silent TQFSelect <C-R><C-W><CR>
nnoremap T<RightMouse> <LeftMouse>:<C-U>silent TQFSelect! <C-R><C-W><CR>
