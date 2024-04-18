local action_layout = require("telescope.actions.layout")
require('telescope').setup{
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- Disable C-u being "sroll previewer" so it retains "kill entire line"
				-- behaviour as in a normal buffer.
				["<C-u>"] = false,
				["<M-p>"] = action_layout.toggle_preview
			},
			n = {
				["<M-p>"] = action_layout.toggle_preview
			},
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
			require('telescope.themes').get_dropdown { }
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
-- This isn't doing what I want yet.
-- I was hoping it would handle the standard vim completion interface, but it
-- doesn't do that -- it handles some subset (see `:help vim.ui.select()`).
require('telescope').load_extension('ui-select')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>cpf', builtin.find_files, {desc = "find files"})
vim.keymap.set('n', '<leader>cp.',
							function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end,
							{desc = "find files in buffers dir"})
vim.keymap.set('n', '<leader>cpr', builtin.git_files, {desc = "git ls-files"})
vim.keymap.set('n', '<leader>cpg', builtin.live_grep, {desc = "live grep"})
vim.keymap.set('n', '<leader>cpb', builtin.buffers, {desc = "buffers"})
-- Buffers for "current working directory" while files searching in "same
-- directory as buffer" because file opening defaults to cwd.
-- Putting this under the "project" extension because it "fits" there in my
-- mind.
vim.keymap.set('n', '<leader>cpd',
							function () builtin.buffers({ cwd_only = true }) end,
							{desc = "buffers below cwd"})
vim.keymap.set('n', '<leader>cph', builtin.help_tags, {desc = "help tags"})
vim.keymap.set('n', '<leader>cp]', builtin.tags, {desc = "tags"})
vim.keymap.set('n', '<leader>cp[', builtin.lsp_workspace_symbols, {desc = "lsp workspace symbols"})
vim.keymap.set('n', '<leader>cpt', builtin.treesitter, {desc = 'treesitter symbols'})
vim.keymap.set('n', '<leader>cpj', builtin.jumplist, {desc = 'jumplist'})

local project = require('telescope').extensions.project
vim.keymap.set('n', '<leader>cpp', project.project, {desc = 'project'})

require('telescope').load_extension('arglist')
local arglist = require('telescope-arglist')
vim.keymap.set('n', '<leader>cpa', arglist.arglist, {desc = 'arglist'})

-- Experimented with `telescope-cmdline`.  Did not like the limitation around
-- special forms for buffers.  Not using it for that reason.
-- TODO in order to get `%:h` working:
-- 1) Need to manage the fact that the buffer where I'm typing this
--    command is different to the buffer which the command will run under
--    (i.e. fundamental implementation behaviour of telescope).
-- 2) Need to ensure that completions returned are actually handled when
--	  we use such special characters.  Doesn't look like it at the
--	  moment.
-- If I ever look at doing something a bit nicer with the command line wildmenu
-- I believe I just want to use `wilder`, since that naturally uses the command
-- line.
-- local cmdline = require('telescope').extensions.cmdline
-- vim.keymap.set('n', '<leader>cp;', cmdline.cmdline, {})
-- vim.keymap.set('n', '<leader>cp:', cmdline.visual, {})
