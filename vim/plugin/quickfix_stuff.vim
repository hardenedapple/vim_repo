" Qargs command from vimcast 45
" Note this function is degenerate with Vimple's QFbufs
" Also, the command Qargs is degenerate with Vimple's QFargs (though QFargs has
" more functionality).
" Despite this, I'm keeping them both, as the "no-plugin" version that I can
" have by not including the plugin_extras/ and bundle/ directory can use these.
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

" Quickfix saving functions from
" http://vim.1045645.n5.nabble.com/Saving-the-Quickfix-List-td1179523.html
function s:SaveQuickFixList(fname)
 let list = getqflist()
 for i in range(len(list))
  if has_key(list[i], 'bufnr')
   let list[i].filename = fnamemodify(bufname(list[i].bufnr), ':p')
   unlet list[i].bufnr
  endif
 endfor
 let string = string(list)
 let lines = split(string, "\n")
 call writefile(lines, a:fname)
endfunction

function s:LoadQuickFixList(fname)
 let lines = readfile(a:fname)
 let string = join(lines, "\n")
 call setqflist(eval(string))
endfunction

" Add commands for the functions above.
command -nargs=0 -bar Qargs execute 'args' s:QuickfixFilenames()
command -bang -nargs=1 -complete=file QFilterBuf call s:FilterQuickfixListByBuffer(<bang>0, <q-args>)
command -bang -nargs=1 QFilterMatch call s:FilterQuickfixListBySubject(<bang>0, <q-args>)
command -bar QuickfixSort call s:SortUniqQFList()
command -bar -nargs=1 SaveQuickFixList call s:SaveQuickFixList(<q-args>)
command -bar -nargs=1 -complete=file LoadQuickFixList call s:LoadQuickFixList(<q-args>)
