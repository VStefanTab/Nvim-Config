return {
  "git@github.com:tpope/vim-fugitive.git",

  config = function()
    -- Fugitive keybindings
    vim.api.nvim_set_keymap(
      "n",
      "<leader>G",
      ":Git<CR>", -- Use a string command for Gstatus
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>gb",
      ":Git blame<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>gd",
      ":Git difftool -y<CR>",
      { noremap = true, silent = true }
    )
  end,
}
