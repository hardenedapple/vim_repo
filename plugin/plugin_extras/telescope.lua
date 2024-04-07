require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
		['ui-select'] = {
			require('telescope.themes').get_dropdown {
			}
		}
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }

}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('project')
require('telescope').load_extension('ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>cpf', builtin.find_files, {})
vim.keymap.set('n', '<leader>cpg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>cpb', builtin.buffers, {})
vim.keymap.set('n', '<leader>cph', builtin.help_tags, {})
vim.keymap.set('n', '<leader>cpt', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>cpp', builtin.treesitter, {})
vim.keymap.set('n', '<leader>cpj', builtin.jumplist, {})

local project = require('telescope').extensions.project
vim.keymap.set('n', '<leader>cpc', project.project, {})
