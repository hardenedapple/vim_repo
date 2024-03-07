-- Temporary so that if I notice something strange I don't have to turn on
-- logging and attempt to reproduce.
-- vim.lsp.set_log_level("TRACE")

-- The below seems to start the LSP server just fine.
-- I'd need to have more conditions (things like only run when asked and only
-- run on C/C++ files) before uncommenting it.
-- N.b. similar to emacs's `eglot` I would like to be able to say "if I've
-- enabled LSP in a given "project", then enable it in all buffers for that
-- project".  I don't think there's anything like that built in to neovim.
vim.api.nvim_create_augroup('personal_lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
	group = "personal_lsp",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.server_capabilities.hoverProvider then
			vim.keymap.set('n', '<localleader>K', vim.lsp.buf.hover, { buffer = args.buf })
		end
		-- TODO Put each of the below under a check that the server has the
		-- functionality.  Needs to find the mapping between the functionality
		-- property and the behaviour that I want.
		vim.keymap.set('n', '<localleader>q', 
					function () vim.diagnostic.setloclist({open = true}) end,
					{ buffer = args.buf })
		vim.keymap.set('n', '<localleader>r', vim.lsp.buf.references, { buffer = args.buf })
		vim.keymap.set('n', '<localleader>w', vim.lsp.buf.workspace_symbol, { buffer = args.buf })
		vim.keymap.set('n', '<localleader>i', vim.lsp.buf.implementation, { buffer = args.buf })
		vim.keymap.set('n', '<localleader>s', vim.lsp.buf.signature_help, { buffer = args.buf })
		vim.keymap.set('i', '<C-q>', vim.lsp.buf.signature_help, { buffer = args.buf })
		-- TODO
		--    vim.lsp.buf.workspace_symbol  (can I use this instead of TQFSelect?)
		--       N.b. it looks like TQFSelect will always use the actual taglist,
		--       and workspace_symbol will not accept regexps (see issue
		--       https://github.com/neovim/neovim/issues/23591).  Hence I guess
		--       both would be useful.
		--		formatting ???? (probably not given the strange GNU format, but maybe can
		--								 figure out a formatting approach that is good enough).
		--								 N.b. if there is a nice formatting available, it might
		--								 be better to use treesitter.
	end,
})

-- Really need to figure out an interface to this that will work nicer.
-- Either do something like Emacs does by automatically associating all source
-- files in a given git repository with the same server (and automatically
-- connecting to a server for each one).
-- Or have some sort of easy selection deciding which server to use for the
-- current buffer whenever I say "use LSP here please".
--
-- For the moment this will likely work, since I only work on large C/C++
-- projects in git.  Will need to figure something out for
-- `compile_commands.json` from a completely different build directory a la GCC
-- and binutils (have hacked a binutils behaviour together before, need a more
-- robust approach).
--
-- TODO This autocmd seems to trigger everywhere it should *except* for opening
-- the very first file.
vim.api.nvim_create_autocmd('FileType', {
	group = "personal_lsp",
	callback = function(event_arg)
		local interesting = {c = true, cpp = true}
		if interesting[event_arg.match] then
			project_cc_json = vim.fs.find(
						{'compile_commands.json'},
						{upward = true,
						 stop = vim.uv.os_homedir(),
						 path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))})[1]
			if project_cc_json then
				vim.lsp.start({
					name = 'clangd LSP server',
					-- cmd = {'clangd', '--log=verbose'},
					cmd = {'clangd'},
					root_dir = vim.fs.dirname(project_cc_json)
				})
			end
		end
	end
})

-- Get rid of the signs in the number column and the virtual text.
-- Can still ask the diagnostics to be shown in a location list (with the
-- key binding above), just don't want things cluttering up my view without
-- explicitly asking for them.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- Disable signs
		signs = false,
		-- Disable virtual_text
		virtual_text = false,
	}
)

