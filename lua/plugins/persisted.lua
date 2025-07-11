return {
	{
		"persisted.nvim",
		event = "BufReadPre",
		for_cat = "general.always",
		keys = {
		},
		after = function()
			require("persisted").setup({
			})
                        require("telescope").load_extension("persisted")
		end,
	},
}
