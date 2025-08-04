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
			settings = {
				basedpyright = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						typeCheckingMode = "basic",
						useLibraryCodeForTypes = true,
					},
				},
			},
		},
	},
}
