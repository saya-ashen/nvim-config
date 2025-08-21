return {
	{
		"ruff",
		enabled = true,
		lsp = {
			on_attach = function(client, bufnr)
				-- 首先，运行通用的 on_attach 函数
				require("plugins.lsp.on_attach")

				client.server_capabilities.definitionProvider = false
			end,
			filetypes = { "python" },
		},
	},
}
