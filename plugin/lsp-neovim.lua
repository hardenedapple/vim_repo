-- The below seems to start the LSP server just fine.
-- I'd need to have more conditions (things like only run when asked and only
-- run on C/C++ files) before uncommenting it.
-- N.b. similar to emacs's `eglot` I would like to be able to say "if I've
-- enabled LSP in a given "project", then enable it in all buffers for that
-- project".  I don't think there's anything like that built in to neovim.

vim.api.nvim_create_autocmd('LspAttach', {
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
		vim.keymap.set('n', '<localleader>i', vim.lsp.buf.implementation, { buffer = args.buf })
		vim.keymap.set('n', '<localleader>s', vim.lsp.buf.signature_help, { buffer = args.buf })
		vim.keymap.set('i', '<C-q>', vim.lsp.buf.signature_help, { buffer = args.buf })
		-- TODO
		--		workspaces (what are these and when can I use them)
		--    vim.lsp.buf.workspace_symbol  (can I use this instead of TQFSelect?)
		--		format ???? (probably not given the strange GNU format, but maybe can
		--								 figure out a formatting approach that is good enough).
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
vim.keymap.set('n', '<localleader>l',
  function ()
		vim.lsp.start({
			name = 'clangd LSP server',
			cmd = {'clangd'},
			root_dir = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1])
			-- temporarily hard-coding for llvm.
			-- root_dir = vim.fs.dirname('/home/matmal01/Documents/work/llvm-builddir')
		})
	end
)

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

