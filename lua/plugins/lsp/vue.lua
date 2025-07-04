return {
	{
		"ts_ls",
		enabled = true,
		lsp = {
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"typescript",
				"vue",
			},
			init_options = {
				plugins = {
					{
					name = "@vue/typescript-plugin",
						location = "",
						languages = { "javascript", "typescript", "vue" },
					},
				},
			},
		},
	},
	{
		"vue_ls",
		enabled = true,
		lsp = {
			cmd = { "vue-language-server", "--stdio" },
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			init_options = {
				vue = {
					hybridMode = true,
				},
			},
		},
	},
}
