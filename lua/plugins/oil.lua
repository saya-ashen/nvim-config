return {
	{
		"oil.nvim",
		for_cat = "general.extra",
		keys = {
			{
				"<leader>o",
				function()
					require("oil").open()
				end,
				desc = "Oil: Open parent directory",
			},
			{
				"<leader>O",
				function()
					require("oil").open(vim.fn.getcwd())
				end,
				desc = "Oil: Open cwd",
			},
		},
		cmd = { "Oil" },
		on_plugin = { "nvim-web-devicons" },
		after = function()
			require("oil").setup({
				default_file_explorer = false, -- Let neo-tree be default, oil as alternative
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
				buf_options = {
					buflisted = false,
					bufhidden = "hide",
				},
				win_options = {
					wrap = false,
					signcolumn = "no",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
				delete_to_trash = false,
				skip_confirm_for_simple_edits = false,
				prompt_save_on_select_new_entry = true,
				cleanup_delay_ms = 2000,
				constrain_cursor = "editable",
				watch_for_changes = false,
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = "actions.select_vsplit",
					["<C-h>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
				use_default_keymaps = true,
				view_options = {
					show_hidden = false,
					is_hidden_file = function(name, _)
						return vim.startswith(name, ".")
					end,
					is_always_hidden = function(name, _)
						return false
					end,
					sort = {
						{ "type", "asc" },
						{ "name", "asc" },
					},
				},
				float = {
					padding = 2,
					max_width = 0,
					max_height = 0,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
				},
				preview = {
					max_width = 0.9,
					min_width = { 40, 0.4 },
					width = nil,
					max_height = 0.9,
					min_height = { 5, 0.1 },
					height = nil,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
				},
				progress = {
					max_width = 0.9,
					min_width = { 40, 0.4 },
					width = nil,
					max_height = { 10, 0.9 },
					min_height = { 5, 0.1 },
					height = nil,
					border = "rounded",
					minimized_border = "none",
					win_options = {
						winblend = 0,
					},
				},
			})
		end,
	},
}