function helpers#external_program_missing(program)
  silent call system('command -v ' . a:program)
  return v:shell_error
endfunction

" Stuff copied from the 'man.vim' default ftplugin.
" I just want to check if a man page exists, and they've already done the hard
" work with the functions there, but unfortunately, the functions are private.
" Hence I'm copying them into a personal file.
" vimcmd: edit /usr/share/vim/vim74/ftplugin/man.vim
let s:man_sect_arg = ""
let s:man_find_arg = "-w"
try
  if !has("win32") && $OSTYPE !~ 'cygwin\|linux' && g:os =~ "SunOS" && system('uname -r') =~ "^5"
    let s:man_sect_arg = "-s"
    let s:man_find_arg = "-l"
  endif
catch /E145:/
  " Ignore the error in restricted mode
endtry

func <SID>GetCmdArg(sect, page)
  if a:sect == ''
    return a:page
  endif
  return s:man_sect_arg.' '.a:sect.' '.a:page
endfunc


func <SID>FindPage(sect, page)
  let where = system("/usr/bin/man ".s:man_find_arg.' '.s:GetCmdArg(a:sect, a:page))
  if where !~ "^/"
    if matchstr(where, " [^ ]*$") !~ "^ /"
      return 0
    endif
  endif
  return 1
endfunc

function helpers#plumb_this()
  echom "Hello there"
  " URL ??
  let fullWORD = expand("<cWORD>")
  execute 'echom "' . fullWORD . '"'
  if l:fullWORD =~# '\w\+://'
    normal gx
    return
  endif

  " Tag ??
  let smallword = expand("<cword>")
  let matchingTags = filter(taglist(l:smallword), 'v:val["name"] == "' . l:smallword . '"')
  if len(l:matchingTags)
    " We can't handle cscope tags -- they too often ask for prompts.
    " Plus the 'taglist()' function returns what's in the 'tags' file, ignoring
    " cscope.out
    let l:currentCscopeTag = &cscopetag
    set nocscopetag
    execute 'tag ' . l:smallword
    let &cscopetag = l:currentCscopeTag
    return
  endif

  " Filename ??
  let startFilename = fnamemodify(matchstr(l:fullWORD, '\f\+'), ':p')
  if filereadable(l:startFilename)
    let fileOutput = system("file " . l:startFilename)
    if fileOutput =~ 'ASCII'
      normal gF
    else
      normal gx
    endif
    return
  endif

  " Taken from the 'man.vim' default ftplugin.
  " vimcmd: edit /usr/share/vim/vim74/ftplugin/man.vim
  if &ft == 'man'
    let old_isk = &iskeyword
    setl iskeyword+=(,)
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
  else
    let str = l:smallword
  endif
  let page = substitute(str, '(*\(\k\+\).*', '\1', '')
  let sect = substitute(str, '\(\k\+\)(\([^()]*\)).*', '\2', '')
  if match(sect, '^[0-9 ]\+$') == -1
    let sect = ""
  endif
  if sect == page
    let sect = ""
  endif
  if sect != "" && s:FindPage(sect, page) == 0
    let sect = ""
  endif
  if s:FindPage(sect, page) != 0
    if &ft == 'man'
      execute "normal \<c-]>"
    else
      execute 'Man ' . sect . page
    endif
  endif

  " By default, search for the text
  call search('\<' . l:smallword . '\>',  'sw')
endfunction

