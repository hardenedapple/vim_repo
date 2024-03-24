-- TODO Have a look at `scope' it has been mentioned a few times as something I
-- could use for these text objects and I don't really know what it is or where
-- it comes from.

--  Built in TextObjects in the plugin (list taken from
--  https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
--     @assignment.inner
--     @assignment.lhs
--     @assignment.outer
--     @assignment.rhs
--     @attribute.inner
--     @attribute.outer
--     @block.inner
--     @block.outer
--     @call.inner
--     @call.outer
--     @class.inner
--     @class.outer
--     @comment.inner      <-- Currently have a poor substitute for comment
--														 textobjects in Commentary plugin, would like
--														 a better implementation.
--     @comment.outer
--     @conditional.inner
--     @conditional.outer
--     @frame.inner
--     @frame.outer
--     @function.inner
--     @function.outer
--     @loop.inner
--     @loop.outer
--     @number.inner
--     @parameter.inner
--     @parameter.outer
--     @regex.inner
--     @regex.outer
--     @return.inner
--     @return.outer
--     @scopename.inner
--     @statement.outer
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        -- -- You can also use captures from other query groups like `locals.scm`
        -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",

				-- For C/C++ probably not that useful (can always use a{ or a}, but
				-- maybe helpful for other languages.
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@function.outer'] = 'V',
        ['@class.outer'] = 'V',
        -- Use '<c-v>' for blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true,
    },

    swap = {
      enable = true,
      swap_next = {
        ["<leader>al"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>ah"] = "@parameter.inner",
      },
    },

		-- N.b. Redefining motion commands so that `[m' etc act on classes and `[['
		-- etc act on functions.  Doing this mostly because the standard `[['
		-- motions in C files act on functions (even though everything is only
		-- defined by "curly brace as first character on the line", that's how
		-- things end up) and I'm not inclined to put these more useful actions on
		-- less familiar (and I believe less easy to type) keybindings.
		-- Moreover, the amount of times I actually want to jump to the
		-- beginning/end of a class are pretty limited.
		-- Keys following `[' not currently defined in mappings:
		--		c g h i j k r s v w z D E F G H I J K N O R S U V W X Y Z
		-- Standard key sequences (i.e. vim default keymappings):
		--    c     i       s     z D         I           S
		-- So keys that are "free" for loops and conditionals:
		--		  g h j k r v w E F G H J K N O R U V W X Y Z
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				-- N.b. I have checked that my VSH mappings override this.
				["]m"] = "@class.outer",
				["]]"] = "@function.outer",
				["]j"] = "@loop.outer",
				["]k"] = "@conditional.outer",
			},
			goto_next_end = {
				["]M"] = "@class.outer",
				["]["] = "@function.outer",
				["]J"] = "@loop.outer",
				["]K"] = "@conditional.outer",
			},
			goto_previous_start = {
				["[m"] = "@class.outer",
				["[["] = "@function.outer",
				["[j"] = "@loop.outer",
				["[k"] = "@conditional.outer",
			},
			goto_previous_end = {
				["[M"] = "@class.outer",
				["[]"] = "@function.outer",
				["[J"] = "@loop.outer",
				["[K"] = "@conditional.outer",
			},
		},
	},
}
