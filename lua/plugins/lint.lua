require("lze").load({
	{
		"nvim-lint",
		for_cat = "lint",
		-- cmd = { "" },
		keys = {
			{
				"<leader>cf",
				mode = { "n" },
				noremap = true,
				function()
					conform.format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					})
				end,
				desc = "Format Code",
			},
		},
		event = "FileType",
		-- ft = "",
		-- keys = "",
		-- colorscheme = "",
		after = function(plugin)
			require("lint").linters_by_ft = {
				markdown = { "vale" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
                                python = { "ruff" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
})
