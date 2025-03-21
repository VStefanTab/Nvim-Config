return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { ".git/" }, -- Ignore .git directory
				},
				pickers = {
					find_files = {
						hidden = true, -- Show hidden files
					},
				},
			})
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set(
				"n",
				"<leader>fg",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				{ desc = "Live Grep" }
			)
			vim.keymap.set("n", "<leader>fc", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			telescope.load_extension("ui-select")
			telescope.load_extension("live_grep_args")
		end,
	},
}
