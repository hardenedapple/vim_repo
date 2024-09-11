local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_layout = require("telescope.actions.layout")
local from_entry = require("telescope.from_entry")
local transform_mod = require("telescope.actions.mt").transform_mod

-- TODO
--	1) Add mapping to arglist picker that removes the selected buffer from the
--		 arglist.
--	2) Move my patch to the "project" extension into configuration here.
--		 I want to change the mappings and add a choice to select buffers from
--		 within that particular project.
--	3) Try out fzf fuzzy finding (instead of fzy which I currently use).

-- Copied from telescope actions directly.
local append_to_history = function(prompt_bufnr)
  action_state
    .get_current_history()
    :append(action_state.get_current_line(), action_state.get_current_picker(prompt_bufnr))
end

local function args_selection(prompt_bufnr, cmd)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local args = {}
	for _, entry in ipairs(picker:get_multi_selection()) do
		table.insert(args, from_entry.path(entry))
	end
	local prompt = picker:_get_prompt()
	actions.close(prompt_bufnr)
	local argcmd = string.format([[%s %s]], cmd, table.concat(args, " "))
	vim.cmd(argcmd)
end

local arglist_actions = {}

arglist_actions.set_args = {
	pre = append_to_history,
	action = function (prompt_bufnr)
		args_selection (prompt_bufnr, "args")
	end,
}
arglist_actions.argadd = {
	pre = append_to_history,
	action = function (prompt_bufnr)
		args_selection (prompt_bufnr, "argadd")
	end,
}
arglist_actions.badd = {
	pre = append_to_history,
	action = function (prompt_bufnr)
		args_selection (prompt_bufnr, "Badd")
	end,
}
arglist_actions = transform_mod(arglist_actions)

require('telescope').setup{
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- Disable C-u being "scroll previewer" so it retains "kill entire
				-- line" behaviour as in a normal buffer.
				-- Move the scrolling to C-e and C-y (as some alternate existing
				-- scrolling mappings).
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<C-y>"] = actions.preview_scrolling_up,
				["<C-e>"] = actions.preview_scrolling_down,
				["<M-p>"] = action_layout.toggle_preview,
				["<M-7>"] = actions.select_all,
				["<M-8>"] = actions.toggle_all,
				["<M-9>"] = actions.drop_all,
				["<C-a>"] = arglist_actions.set_args,
				["<C-b>"] = arglist_actions.argadd,
				["<M-b>"] = arglist_actions.badd
			},
			n = {
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<C-y>"] = actions.preview_scrolling_up,
				["<C-e>"] = actions.preview_scrolling_down,
				["<M-p>"] = action_layout.toggle_preview,
				["&"] = actions.select_all,
				["*"] = actions.toggle_all,
				["("] = actions.drop_all,
				["#"] = arglist_actions.set_args,
				["+"] = arglist_actions.argadd,
				["<M-b>"] = arglist_actions.badd
			},
		}
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer + actions.move_to_top,
				}
			}
		}
	},
	extensions = {
		['ui-select'] = {
			require('telescope.themes').get_dropdown { }
		},
		-- Your extension configuration goes here:
		-- extension_name = {
			--   extension_config_key = value,
			-- }
			-- please take a look at the readme of the extension you want to configure
		project = {
			cd_scope = { "tab", "global", "window" },
		}
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
-- N.b. be very careful about using the `tags` picker.  In large projects it
-- can end up with vim taking a *lot* of memory and not releasing it.
vim.keymap.set('n', '<leader>cp]', builtin.tags, {desc = "tags"})
vim.keymap.set('n', '<leader>cp[', builtin.lsp_workspace_symbols, {desc = "lsp workspace symbols"})
vim.keymap.set('n', '<leader>cpt', builtin.treesitter, {desc = 'treesitter symbols'})
vim.keymap.set('n', '<leader>cpj', builtin.jumplist, {desc = 'jumplist'})
vim.keymap.set('n', '<leader>cpq', builtin.quickfix, {desc = 'quickfix'})

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
