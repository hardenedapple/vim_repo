" Python-mode base functions


fun! pymode#BlockStart(lnum, ...) "{{{
    let pattern = a:0 ? a:1 : '^\s*\(@\|class\s.*:\|def\s\)'
    let lnum = a:lnum + 1
    let indent = 100
    while lnum
        let lnum = prevnonblank(lnum - 1)
        let test = indent(lnum)
        let line = getline(lnum)
        if line =~ '^\s*#' " Skip comments
            continue
        elseif !test " Zero-level regular line
            return lnum
        elseif test >= indent " Skip deeper or equal lines
            continue
        " Indent is strictly less at this point: check for def/class
        elseif line =~ pattern && line !~ '^\s*@'
            return lnum
        endif
        let indent = indent(lnum)
    endwhile
    return 0
endfunction "}}}


fun! pymode#BlockEnd(lnum, ...) "{{{
    let indent = a:0 ? a:1 : indent(a:lnum)
    let lnum = a:lnum
    while lnum
        let lnum = nextnonblank(lnum + 1)
        if getline(lnum) =~ '^\s*#' | continue
        elseif lnum && indent(lnum) <= indent
            return lnum - 1
        endif
    endwhile
    return line('$')
endfunction "}}}


" vim: fdm=marker:fdl=0
