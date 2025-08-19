return {
	{ "plenary.nvim" },
	{ "nui.nvim", for_cat = "general.ui" },
	{ "mini.pick" },
	{
		-- Make sure to set this up properly if you have lazy=true
		"render-markdown.nvim",
		for_cat = "general.ai",
		event = "DeferredUIEnter",
		ft = { "markdown", "Avante" },
		after = function()
			require("render-markdown").setup({ file_types = { "markdown", "Avante" } })
		end,
	},
	{
		"copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		for_cat = "general.ai",
		event = "DeferredUIEnter",
		after = function()
			require("copilot").setup({
				suggestion = {
					enabled = false,
					auto_trigger = true,
					keymap = {
						accept = "<C-f>",
						next = "<M-]>",
						prev = "<M-[>",
					},
				},
				panel = { enabled = false },
				filetypes = {
					markdown = true,
					help = true,
				},
			})
		end,
	},
	-- {
	-- 	"avante.nvim",
	-- 	event = "DeferredUIEnter",
	-- 	for_cat = "general.ai",
	-- 	on_plugin = {
	-- 		"render-markdown.nvim",
	-- 		"plenary.nvim",
	-- 		"nui.nvim",
	-- 		"mini.pick",
	-- 		"telescope.nvim",
	-- 		"snacks.nvim",
	-- 		"copilot.lua",
	-- 	},
	-- 	after = function()
	-- 		require("avante").setup({
	-- 			input = {
	-- 				provider = "snacks", -- "native" | "dressing" | "snacks"
	-- 				provider_opts = {
	-- 					-- Snacks input configuration
	-- 					title = "Avante Input",
	-- 					icon = " ",
	-- 					placeholder = "Enter your API key...",
	-- 				},
	-- 			},
	-- 			provider = "copilot",
	-- 			auto_suggestions_provider = "copilot",
	-- 			providers = {
	-- 				copilot = {
	-- 					endpoint = "https://api.githubcopilot.com",
	-- 					model = "gpt-5",
	-- 					proxy = nil, -- [protocol://]host[:port] Use this proxy
	-- 					allow_insecure = false, -- Allow insecure server connections
	-- 					timeout = 30000, -- Timeout in milliseconds
	-- 					context_window = 64000, -- Number of tokens to send to the model for context
	-- 					extra_request_body = {
	-- 						temperature = 0.75,
	-- 						max_tokens = 20480,
	-- 					},
	-- 				},
	-- 			},
	-- 			behaviour = {
	-- 				auto_suggestions = false,
	-- 				auto_set_highlight_group = true,
	-- 				auto_set_keymaps = true,
	-- 				auto_apply_diff_after_generation = false,
	-- 				support_paste_from_clipboard = false,
	-- 				minimize_diff = true, -- 是否在应用代码块时删除未更改的行
	-- 				enable_token_counting = true, -- 是否启用令牌计数。默认为 true。
	-- 				enable_cursor_planning_mode = false, -- 是否启用 Cursor 规划模式。默认为 false。
	-- 				enable_claude_text_editor_tool_mode = false, -- 是否启用 Claude 文本编辑器工具模式。
	-- 			},
	-- 			mappings = {
	-- 				---@class AvanteConflictMappings
	-- 				diff = {
	-- 					ours = "co",
	-- 					theirs = "ct",
	-- 					all_theirs = "ca",
	-- 					both = "cb",
	-- 					cursor = "cc",
	-- 					next = "]x",
	-- 					prev = "[x",
	-- 				},
	-- 				suggestion = {
	-- 					accept = "<M-l>",
	-- 					next = "<M-]>",
	-- 					prev = "<M-[>",
	-- 					dismiss = "<C-]>",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
