My vim dir so that I can easily get my working environment wherever I roam.

CLASHES:

    NOTE:
        I've only tested the compatabilities on Arch which has python3 as
        default, this might cause some problems - I don't know.

    To use python3 jedi omnicompletion etc, need vim compiled with python3
        this breaks python-mode, so copy the pymode motion and indent scripts
        both from 'autoload' directory, and 'after' directory and apply patches
        to remove pymode interdependancies

    If compiled with python3, use the python_stuff patches to salvage what we
        can from python-mode and don't try to use clang_complete repo - instead
        use clang_complete vimball from vim.org (scriptid=3302)
    If compiled with python2, use python-mode and use clang_complete with
        libclang.so library


NOTES:
    The python script to get upgrades is written for python3.

    Quite a few things don't work with older versions of vim
        see the plugins respective websites

    Can't get clang_complete to work with vim compiled with only python3
        works fine with python2 compiled vim.


CREDITS:
    Pylight and techras are my modified versions of github and default resp.
    Everything else comes from someone else - I've just collected them.
    Things hard to google:
        most colors come from vim-colorsamplerpack arch package.
        (colordiff is difference between vim-colorsamplerpack and directory
        that works with set_colors)
