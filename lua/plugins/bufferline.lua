return {
  {
    "akinsho/bufferline.nvim",    -- The plugin repository
    version = "*",                -- Use the latest stable version
    dependencies = "nvim-tree/nvim-web-devicons", -- To show file icons in the bufferline
    config = function()
      require("bufferline").setup({
        options = {
          -- Bufferline options
          numbers = "none", -- "ordinal" | "buffer_id" | "both" | function
          close_command = "bdelete! %d", -- Command to close a buffer
          right_mouse_command = "bdelete! %d", -- Command on right mouse click
          left_mouse_command = "buffer %d", -- Command on left click
          middle_mouse_command = nil, -- Disable middle-click to close buffer
          indicator = {
            style = "icon", -- Can also be "underline" or "none"
            icon = "▎",
          },
          separator_style = "slant", -- "slant" | "thick" | "thin"
          enforce_regular_tabs = true,
          show_buffer_close_icons = true,
          show_close_icon = false,
          diagnostics = "nvim_lsp", -- Integrate with LSP diagnostics
        },
      })

      vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<Tab>o", "<Cmd>BufferLineCloseOthers<CR>", { noremap = true, silent = true })
    end,
    },
}
