require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 2, -- Maximum number of lines to show for a single context
  trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = '-',
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

-- N.b. vim.api.nvim_set_hl changes the values rather than just updating them.
-- Hence using the standard vim `highlight` groups.
vim.cmd([[highlight TreesitterContext ctermbg=235]])
vim.cmd([[highlight TreesitterContextLineNumber ctermbg=235]])

-- Not entirely sure I like this.
-- Wondering about something that pops-up on a keypress to tell me the current
-- function, rather than something always there at the top of the screen.
