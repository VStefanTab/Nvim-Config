vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=2")

-- Enable line numbers and relative numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Leadr key
vim.g.mapleader = " "

-- Moving half screen down/up
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- SplitScreen keys
vim.keymap.set("n", "<Leader>-", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>|", ":vsplit<CR>", { noremap = true, silent = true })

-- Moving through split screens
vim.keymap.set("n", "<Leader>h", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>l", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>j", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>k", "<C-w>k", { noremap = true, silent = true })

-- Resizing split screens
vim.o.equalalways = true
vim.keymap.set("n", "<Leader>=", "<C-w>=", { noremap = true, silent = true })                        -- Equalize
vim.keymap.set("n", "<Leader><Up>", ":resize +5<CR>", { noremap = true, silent = true })             -- Increase height
vim.keymap.set("n", "<Leader><Down>", ":resize -5<CR>", { noremap = true, silent = true })           -- Decrease height
vim.keymap.set("n", "<Leader><Left>", ":vertical resize -5<CR>", { noremap = true, silent = true })  -- Decrease width
vim.keymap.set("n", "<Leader><Right>", ":vertical resize +5<CR>", { noremap = true, silent = true }) -- Increase width

-- Killing every window except the focused one
vim.keymap.set("n", "<Leader>a", ":only<CR>", { noremap = true, silent = true })

--vim.keymap.set("n", "<leader>p", '"0p', {noremap = true, silent = true})

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
    { "LazyVim/LazyVim" },
    --{ import = "lazyvim.plugins.extras.lang.rust" },
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
  },              -- automatically check for plugin updates
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
