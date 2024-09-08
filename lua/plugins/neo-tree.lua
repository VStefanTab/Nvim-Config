local function close_neo_tree()
	-- Close neo-tree if it's open
	vim.cmd("Neotree close")
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				width = 30,
				auto_expand_width = false,
			},
		})

		-- Keymap to open Neo-tree
		vim.keymap.set("n", "<C-t>", ":Neotree filesystem reveal left<CR>", {})

		-- Keymap to close Neo-tree
		vim.keymap.set("n", "<Esc>t", close_neo_tree, {})
	end,
}
