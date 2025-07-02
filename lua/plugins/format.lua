require("lze").load({
	{
		"conform.nvim",
		for_cat = "format",
		-- cmd = { "" },
		-- event = "",
		-- ft = "",
		keys = {
			{ "<leader>cf", desc = "Format Code" },
		},
		-- colorscheme = "",
		after = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					nix = { "nixfmt" },
					python = { "ruff" },
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format Code" })
		end,
	},
})
