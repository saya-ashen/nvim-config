return {
	{
		"aerial.nvim",
		event = "DeferredUIEnter",
		for_cat = "general.code",
		keys = {
			{
				"<leader>cs",
				mode = { "n" },
				"<cmd>AerialToggle<cr>",
				desc = "Aerial (Symbols)",
			},
		},
		after = function()
			require("flash").setup()
		end,
	},
}
