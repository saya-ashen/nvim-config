local colorschemeName = nixCats("colorscheme")
vim.cmd.colorscheme(colorschemeName)

local ok, notify = pcall(require, "notify")
if ok then
	notify.setup({
		on_open = function(win)
			vim.api.nvim_win_set_config(win, { focusable = false })
		end,
	})
	vim.notify = notify
	vim.keymap.set("n", "<Esc>", function()
		notify.dismiss({ silent = true })
	end, { desc = "dismiss notify popup and clear hlsearch" })
end

require("lze").register_handlers(require("nixCatsUtils.lzUtils").for_cat)
require("lze").register_handlers(require("lzextras").lsp)
require("plugins.lsp")
if nixCats("debug") then
	require("plugins.debug")
end
if nixCats("lint") then
	require("plugins.lint")
end
if nixCats("format") then
	require("plugins.format")
end
if nixCats("general.extra") then
	vim.g.loaded_netrwPlugin = 1
end

require("lze").load({
	{ import = "plugins.telescope" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.completion" },
	{ import = "plugins.markdown-preview" },
	{ import = "plugins.mini" },
	{ import = "plugins.which-key" },
	{ import = "plugins.yazi" },
	{ import = "plugins.gitsigns" },
	{ import = "plugins.lualine" },
	{ import = "plugins.flash" },
	{ import = "plugins.snacks" },
	{ import = "plugins.noice" },
	{ import = "plugins.ufo" },
	{ import = "plugins.avante" },
	-- { import = "plugins.dashboard" },
	{ import = "plugins.bufferline" },
	{
		"comment.nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		after = function()
			require("Comment").setup()
		end,
	},
	{
		"indent-blankline.nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		after = function()
			require("ibl").setup()
		end,
	},
	{
		"nvim-surround",
		for_cat = "general.always",
		event = "DeferredUIEnter",
		-- keys = "",
		after = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"vim-startuptime",
		for_cat = "general.extra",
		cmd = { "StartupTime" },
		before = function(_)
			vim.g.startuptime_event_width = 0
			vim.g.startuptime_tries = 10
			vim.g.startuptime_exe_path = nixCats.packageBinPath
		end,
	},
	{
		"fidget.nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		-- keys = "",
		after = function()
			require("fidget").setup({})
		end,
	},
})
