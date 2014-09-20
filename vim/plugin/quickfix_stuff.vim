" Qargs command from vimcast 45
function s:QuickfixFilenames()
    " Building a hash ensures we get each buffer only once
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction


" Filter quicklist from http://dhruvasagar.com/tag/vim
function s:FilterQuickfixListByBuffer(bang, pattern)
    let cmp = a:bang ? '!~#' : '=~#'
    call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . cmp . "a:pattern"))
endfunction

function s:FilterQuickfixListBySubject(bang, pattern)
    let cmp = a:bang ? '!~#' : '=~#'
    call setqflist(filter(getqflist(), "v:val['text'] " . cmp . "a:pattern"))
endfunction


" Sort and remove duplicates in qflist
" http://vim.wikia.com/wiki/Automatically_sort_Quickfix_list
function s:CompareQuickfixEntries(i1, i2)
  if bufname(a:i1.bufnr) == bufname(a:i2.bufnr)
    return a:i1.lnum == a:i2.lnum ? 0 : (a:i1.lnum < a:i2.lnum ? -1 : 1)
  else
    return bufname(a:i1.bufnr) < bufname(a:i2.bufnr) ? -1 : 1
  endif
endfunction

function s:SortUniqQFList()
  let sortedList = sort(getqflist(), 's:CompareQuickfixEntries')
  let uniqedList = []
  let last = ''
  for item in sortedList
    let this = bufname(item.bufnr) . "\t" . item.lnum
    if this !=# last
      call add(uniqedList, item)
      let last = this
    endif
  endfor
  call setqflist(uniqedList)
endfunction


" Add commands for the functions above.
command -nargs=0 -bar Qargs execute 'args' s:QuickfixFilenames()
command -bang -nargs=1 -complete=file QFilterBuf call s:FilterQuickfixListByBuffer(<bang>0, <q-args>)
command -bang -nargs=1 QFilterMatch call s:FilterQuickfixListBySubject(<bang>0, <q-args>)
command -bar QuickfixSort call s:SortUniqQFList()
