local function term_nav(dir)
	---@param self snacks.terminal
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end
return {
	{
		"snacks.nvim",
		for_cat = "general.ui",
		event = "VimEnter",
		keys = {
			{
				"<c-/>",
				mode = { "n" },
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"",
				mode = { "n" },
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<leader>ft",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
		},
		after = function()
			vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
			vim.keymap.set("t", "", "<cmd>close<cr>", { desc = "Hide Terminal" })
			require("snacks").setup({
				bigfile = { enabled = true },
				explorer = { enabled = false },
				dashboard = { enabled = false },
				indent = { enabled = true },
				input = { enabled = true },
				picker = { enabled = true },
				notifier = { enabled = false },
				quickfile = { enabled = true },
				scope = { enabled = true },
				scroll = { enabled = true },
				statuscolumn = { enabled = true },
				words = { enabled = true },
				terminal = {
					enabled = true,
                                        start_insert=false,
                                        auto_insert=false,
					win = {
						keys = {
							nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
							nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
							nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
							nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
						},
						term_normal = {
							"<esc>",
							function(self)
								vim.cmd("stopinsert")
							end,
							mode = "t",
							expr = true,
							desc = "Double escape to normal mode",
						},
					},
				},
			})
		end,
	},
}
