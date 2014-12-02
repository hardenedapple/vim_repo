My vim dir so that I can easily get my working environment wherever I roam.

CLASHES:

    NOTE:
        I've only tested the compatabilities on Arch which has python3 as
        default, this might cause some problems - I don't know.

    If compiled with python3, use the python_stuff patches to salvage what we
        can from python-mode and don't try to use clang_complete repo - instead
        use clang_complete vimball from vim.org (scriptid=3302)
    If compiled with python2, use python-mode and use clang_complete with
        libclang.so library


NOTES:
    Sometimes the python foldexpr isn't applied.
        To reapply, can use a temporary variable with
            let g:mytempvar="<C-r>=&foldexpr"
        in a buffer with the correct foldexpr applied, and
            set foldexpr="<C-r>=g:mytempvar"
        in the non-working buffer.

    The python script to get upgrades is written for python3.

    Quite a few things don't work with older versions of vim
        see the plugins respective websites

    Can't get clang_complete to work with vim compiled with only python3
        works fine with python2 compiled vim.


CREDITS:
    Pylight and techras are my modified versions of github and default resp.
    The Pylight airline theme is copied and pasted from lucius to make airline
        load it automatically
    Everything else comes from someone else - I've just collected them.
    Things hard to google:
        most colors come from vim-colorsamplerpack arch package.
        (colordiff is difference between vim-colorsamplerpack and directory
        that works with set_colors)
