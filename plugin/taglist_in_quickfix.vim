" Search for a certain tag, save all the results as a quickfix list.

let s:kind_tag_dict = {
      \ 'f' : 'function',
      \ 'm' : 'method',
      \ 'c' : 'class',
      \ }

function s:convert_entry(entry)
  let entry = a:entry
  if !str2nr(entry.cmd)
    let entry.pattern = '\M' . entry.cmd[1:-2]
  else
    let entry.lnum = str2nr(entry.cmd)
  endif
  let entry.filename = entry.filename
  let entry.text = get(s:kind_tag_dict, entry.kind, 'unknown tag-kind "' . entry.kind . '"') . ':	' . entry.name
  unlet entry.name entry.kind entry.cmd
  return entry
endfunction

function s:TagSelectToQuickfix(pattern)
  let pattern = empty(a:pattern) ? '.' : a:pattern
  call setqflist(map(taglist(pattern), 's:convert_entry(v:val)'))
  copen
endfunction

command -bar -nargs=? TQFSelect call s:TagSelectToQuickfix(<q-args>)
