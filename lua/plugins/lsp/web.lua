return {
	{
		"ts_ls",
		enabled = false,
		lsp = {
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"typescript",
				"vue",
				"tsx",
				"javascriptreact",
				"typescriptreact",
			},
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "",
						languages = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "tsx" },
					},
				},
			},
		},
	},
	{
		"vtsls",
		enabled = true,
		lsp = {
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			init_options = {
				vue = {
					hybridMode = true,
				},
			},
		},
	},
}
