return {
	{
		"mini.icons",
		for_cat = "general.mini",
		event = "DeferredUIEnter",
		after = function()
			require("mini.icons").setup()
		end,
	},
	{
		"mini.files",
		for_cat = "general.mini",
		event = "DeferredUIEnter",
		keys = {
			{
				"<leader>e",
				function()
					return require("mini.files").open()
				end,
				mode = { "n" },
				desc = "mini.files",
			},
		},
		on_plugin = { "mini.icons" },
		after = function()
			require("mini.files").setup()
		end,
	},
	{
		"mini.pairs",
		event = "DeferredUIEnter",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
		after = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"mini.ai",
		event = "DeferredUIEnter",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
		after = function()
			require("mini.ai").setup()
		end,
	},
	{
		-- "mini.animate",
		-- event = "DeferredUIEnter",
		-- opts = function()
		-- 	local animate = require("mini.animate")
		-- 	return {
		-- 	}
		-- end,
		-- after = function()
		-- 	require("mini.animate").setup()
		-- end,
	},
}
