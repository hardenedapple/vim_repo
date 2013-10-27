My vim dir so that I can easily get my working environment wherever I roam.

CLASHES:
    vim-lawrencium: <C-S> Hgcommit, terminal overrides with freeze

    NerdCommenter uses '\cc' to comment single line and '\cs' to comment 'sexily'
    
    To use python3 jedi omnicompletion etc, need vim compiled with python3
        this breaks python-mode.

    So copy the pymode motion and indent scripts: 
        both from 'autoload' directory, and 'after' directory
        and apply patches to remove pymode interdependancies

    If compiled with python3, symlink python-extra into .vim/bundle directory
        and don't try to use clang_complete - instead use clang_complete
        vimball from vim.org (scriptid=3302)
    If compiled with python2, symlink python-mode into .vim/bundle directory
        and use clang_complete with libclang.so library


NOTES:
    The python script to get upgrades is written for python3.

    Quite a few things don't work with older versions of vim
        see the plugins respective websites

    Can't get clang_complete to work with vim compiled with only python3
        works fine with python2 compiled vim.


CREDITS:
    Pylight and techras are my modified versions of github and default resp.
    Everything comes from someone else - I've just collected them.
    Things hard to google:
        most colors come from vim-colorsamplerpack arch package.
        (colordiff is difference between vim-colorsamplerpack and directory that
        works with set_colors)

REQUIREMENTS:
    gundo:              vim 7.3 with python 2.4+ support
    clang_complete:     vim 7.3  - better with python 2.7 and conceal feature,
                        also with libclang.so on the path.
