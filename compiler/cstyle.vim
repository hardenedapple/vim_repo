" Vim Compiler File
" Compiler:	ant
" Maintainer:	Johannes Zellner <johannes@zellner.org>
" Last Change:	Mi, 13 Apr 2005 22:50:07 CEST

if exists("current_compiler")
    finish
endif
let current_compiler = "cstyle"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=cstyle\ -pP\ %

" Error format for 'cstyle' function
set errorformat=%f:\ %l:\ %m
