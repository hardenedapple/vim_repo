-- TODO Check for `snippets' being in vim.g.pathogen and `return' from this
-- script.
for _,v in pairs(vim.g.pathogen_disabled) do
	if v == 'snippets' then
		return
	end
end

local snippets = require('snippets')
snippets.setup({
	friendly_snippets = true,
	-- create_autocmd = true,
	create_cmp_source = false
})

local function get_current_word()
	local current_line = vim.api.nvim_get_current_line()
	local position = vim.fn.getcurpos()
	local before_cursor = string.sub(current_line, 1, position[3])
	return string.gsub(before_cursor, '.* ', '')
end

local function snippet_move(dir)
	if vim.snippet.active({ direction = dir }) then
		vim.snippet.jump(dir)
	else
		vim.snippet.stop()
	end
end
local function do_next() snippet_move(1) end
local function do_prev() snippet_move(-1) end

function body_as_string(body)
	if type(body) == 'table' then
		body = table.concat(body, '\n')
	end
	return body
end
function do_expand()
	local cword = get_current_word()
	snippets.load_snippets_for_ft(vim.bo.filetype)
	local snip = snippets.loaded_snippets[cword]
	if snip then
		local body = body_as_string(snip.body)
		vim.cmd('normal! dvB')
		vim.snippet.expand(body)
	end
end

local function snippet_format(snip)
	return string.format("%s | %s:  %s", snip.prefix, snip.name, snip.description)
end
local function choose_snippet()
	snippets.load_snippets_for_ft(vim.bo.filetype)
	local items = {}
	local count = 1
	for k,v in pairs(snippets.loaded_snippets) do
		items[count] = vim.tbl_deep_extend("force", {}, { name = k }, v)
		count = count + 1
	end
	vim.ui.select(items, {prompt = 'Choose snippet', format_item = snippet_format},
								function(item) if item then vim.snippet.expand(body_as_string(item.body)) end end)
end

vim.keymap.set('i', '<M-;>', do_expand,
								{silent = true, desc = 'expand at point'})
vim.keymap.set('i', '<M-:>', choose_snippet,
								{silent = true, desc = 'choose snippet'})
vim.keymap.set({ 'i', 's' }, '<C-j>', do_next,
								{silent = true, desc = 'move snippet forwards'})
vim.keymap.set({ "i", "s" }, '<C-k>', do_prev,
								{silent = true, desc = 'move snippet backwards'})

