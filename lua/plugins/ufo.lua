return {
	{ "promise-async" },
	{
		"nvim-ufo",
		event = "DeferredUIEnter",
		on_plugin = { "promise-async" },
		for_cat = "general.always",
		keys = {
			{
				"zM",
				mode = { "n" },
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close All Folds",
			},
			{
				"zR",
				mode = { "n" },
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open All Folds",
			},
			{
				"zr",
				mode = { "n" },
				function()
					require("ufo").openFoldsExceptKinds()
				end,
				desc = "Fold Less",
			},
			{
				"zm",
				mode = { "n" },
				function()
					require("ufo").closeFoldsWith()
				end,
				desc = "Fold More",
			},
			{
				"zp",
				mode = { "n" },
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end,
				desc = "Peek Fold",
			},
		},
		after = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
				open_fold_hl_timeout = 150,
				close_fold_kinds_for_ft = {
					default = { "imports", "comment" },
					json = { "array" },
					c = { "comment", "region" },
				},
				preview = {
					win_config = {
						border = { "", "─", "", "", "", "─", "", "" },
						winhighlight = "Normal:Folded",
						winblend = 0,
					},
					mappings = {
						scrollU = "<C-u>",
						scrollD = "<C-d>",
						jumpTop = "[",
						jumpBot = "]",
					},
				},
			})
		end,
	},
}
