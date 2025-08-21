return {
	{
		"basedpyright",
		enabled = true,
		-- provide a table containing filetypes,
		-- and then whatever your functions defined in the function type specs expect.
		-- in our case, it just expects the normal lspconfig setup options,
		-- but with a default on_attach and capabilities
		lsp = {
			filetypes = { "python" },
			on_attach = function(client, bufnr)
				-- 首先，运行通用的 on_attach 函数
				require("plugins.lsp.on_attach")

				client.server_capabilities.definitionProvider = false
			end,
			settings = {
				basedpyright = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						typeCheckingMode = "basic",
						useLibraryCodeForTypes = true,
						-- autoImportCompletions = false,
					},
				},
			},
		},
	},
}
