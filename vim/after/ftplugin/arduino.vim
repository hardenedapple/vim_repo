if exists("b:did_plugin")
    finish
endif

runtime! ftplugin/c.vim ftplugin/c_*.vim ftplugin/c/*.vim
