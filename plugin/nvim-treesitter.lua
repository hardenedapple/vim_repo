-- Originally I thought that having treesitter handle syntax highlighting would
-- make things faster.  It doesn't look to be the case.
--
-- Certainly with large files like `gcc/config/aarch64/aarch64.cc` it looks
-- like having treesitter instead of regexp highlighting makes inserting text
-- much slower.
--
-- Using treesitter for folding seems to work quite well on the other hand.
-- I've configured that in `after/ftplugin/c_languages.vim`.


-- Below turns on syntax highlighting, am keeping it off for speed.

require('nvim-treesitter').install({ "c", "cpp", "python", "lua", "vim", "vimdoc", "query", "rust", "tlaplus" }):wait(300000)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "cpp", "python", "lua", "vim", "vimdoc", "query", "rust", "tlaplus" },
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    local line_count = vim.api.nvim_buf_line_count(ev.buf)
    if (ft == 'cpp' or ft == 'c' or ft == 'org') and line_count < 10000 then
      vim.treesitter.start()
      -- folds, provided by Neovim
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      -- indentation, provided by nvim-treesitter
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
