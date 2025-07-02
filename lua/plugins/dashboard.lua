return {
	{
		"dashboard-nvim",
		for_cat = "general.ui",
		after = function()
			require("dashboard").setup({
				theme = "doom",
				hide = {},
				config = {
					week_header = {
						enable = true,
					},
					center = {
						{
							action = "ene | startinsert",
							desc = " New File",
							icon = " ",
							key = "n",
						},
						{
							icon = " ",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							action = 'lua require("persistence").load()',
							desc = " Restore Session",
							icon = " ",
							key = "s",
						},
						{
							action = function()
								vim.api.nvim_input("<cmd>qa<cr>")
							end,
							desc = " Quit",
							icon = " ",
							key = "q",
						},
					},
				},
			})
		end,
	},
}
