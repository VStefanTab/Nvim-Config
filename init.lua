vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number relativenumber")
vim.g.mapleader = " "

vim.keymap.set("n", "<C-W>", ":update<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc><Esc>",":q<CR>", { noremap = true, silent = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--local opts = {}

require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
	  --{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
    --{ import = "lazyvim.plugins.extras.dap.core" },
		-- import/override with your plugins
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	--install = { colorscheme = { "tokyonight", "habamax" } },
	checker = {
		enabled = true, -- check for plugin updates periodically
		notify = true, -- notify on update
	}, -- automatically check for plugin updates
--	  performance = {
--	    rtp = {
--	      -- disable some rtp plugins
--	      disabled_plugins = {
--	        "gzip",
--	        -- "matchit",
--	        -- "matchparen",
--	        -- "netrwPlugin",
--	        "tarPlugin",
--	        "tohtml",
--	        "tutor",
--	        "zipPlugin",
--          "tokyonight",
--          "persistance",
--
--	      },
--	    },
--	  },
})
