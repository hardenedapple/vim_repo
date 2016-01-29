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
        I've yet to look into why this happens.

    Quite a few things don't work with older versions of vim
        I check for this in my vimrc, but it does mean features are lost
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
        (odds_ends/colordiff is difference between vim-colorsamplerpack and
        directory that works with set_colors)

Neovim:
    Tmux escape-time:
        Neovim distinguishes between Alt-j and <ESC>j in the terminal
        This is determined by whether the '^[' and 'j' characters come at the
        same time or one after each other.
        Tmux has an 'escape-time' variable that does pretty much the same, if
        the second character comes after this number of milliseconds then the
        button pressed was an Alt/Function/whatever key.
        Tmux's default value for this parameter is 500 milliseconds, which is
        too long for use in vim.
        Change this whenever using nvim inside terminal.

