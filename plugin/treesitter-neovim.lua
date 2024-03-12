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

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "cpp", "python", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
		-- Disable in large C/C++ buffers (have seen slowness here)
		-- Have not yet trial and errored where the limit is, but I definitely saw
		-- slowness in aarch64.cc (which is ~35000 lines long)
		disable = function (lang, bufnr)
			return (lang == "cpp" or lang == "c") and vim.api.nvim_buf_line_count(bufnr) > 10000
		end,
  },
}