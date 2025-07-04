return {
	{ "promise-async",  },
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
				desc = "Open yazi at the current file",
			},
			{
				"zR",
				mode = { "n" },
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open yazi at the current file",
			},
		},
		after = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
}
