local wilder = require('wilder')
wilder.setup({modes = {':'},
							enable_cmdline_enter = 0})
wilder.set_option('renderer', wilder.popupmenu_renderer({
	-- highlighter applies highlighting to the candidates
	highlighter = wilder.basic_highlighter(),
}))
