return {
	{
		"project.nvim",
		for_cat = "general.extra",
		event = "VimEnter",
		keys = {
			{
				"<leader>fp",
				function()
					require("telescope").extensions.projects.projects({})
				end,
				desc = "Projects",
			},
		},
		on_plugin = { "telescope.nvim" },
		after = function()
			require("project_nvim").setup({
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "flake.nix" },
				ignore_lsp = {},
				exclude_dirs = {},
				show_hidden = false,
				silent_chdir = true,
				scope_chdir = "global",
				datapath = vim.fn.stdpath("data"),
			})
			require("telescope").load_extension("projects")
		end,
	},
}