return {
	{
		"toggleterm.nvim",
		for_cat = "general.extra",
		keys = {
			{
				"<leader>tt",
				"<cmd>ToggleTerm<cr>",
				desc = "Toggle Terminal",
			},
			{
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<cr>",
				desc = "Float Terminal",
			},
			{
				"<leader>th",
				"<cmd>ToggleTerm direction=horizontal<cr>",
				desc = "Horizontal Terminal",
			},
			{
				"<leader>tv",
				"<cmd>ToggleTerm direction=vertical size=80<cr>",
				desc = "Vertical Terminal",
			},
		},
		cmd = { "ToggleTerm", "TermExec" },
		after = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.3
					end
				end,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				auto_scroll = true,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
				winbar = {
					enabled = false,
					name_formatter = function(term)
						return term.name
					end,
				},
			})

			-- Set keymaps for terminal mode
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- Apply keymaps to terminals
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

			-- Create some useful terminal commands
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "double",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
				on_close = function(_)
					vim.cmd("startinsert!")
				end,
			})

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end

			local node = Terminal:new({ cmd = "node", hidden = true })
			function _NODE_TOGGLE()
				node:toggle()
			end

			local python = Terminal:new({ cmd = "python", hidden = true })
			function _PYTHON_TOGGLE()
				python:toggle()
			end

			-- Add keymaps for the special terminals
			vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "LazyGit" })
			vim.keymap.set("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Node Terminal" })
			vim.keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Python Terminal" })
		end,
	},
}