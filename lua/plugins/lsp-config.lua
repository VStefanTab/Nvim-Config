return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensured_installed = { "lua_ls", "clangd", "cmake", "pyright" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.cmake.setup({
				capabilities = capabilities,
				cmd = { "cmake-language-server" },
				filetypes = { "cmake" },
				init_options = {
					buildDirectory = "build",
				},
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.omnisharp.setup({
				cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/omnisharp") },
				root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", "*.cs") or vim.fn.getcwd(),
			})

			lspconfig.zls.setup({
				capabilities = capabilities,
				settings = {
					zls = {
						-- Whether to enable build-on-save diagnostics
						--
						-- Further information about build-on save:
						-- https://zigtools.org/zls/guides/build-on-save/
						-- enable_build_on_save = true,

						-- Neovim already provides basic syntax highlighting
						semantic_tokens = "partial",
					},
				},
			})
			lspconfig.r_language_server.setup({
				capabilities = capabilities,
				cmd = { "R", "--slave", "-e", "languageserver::run()" },
				filetypes = { "r", "rmd" },
				log_level = 2,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		end,
	},
}
