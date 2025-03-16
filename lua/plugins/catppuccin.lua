return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- Set the Catppuccin flavor (e.g., "mocha", "macchiato", "frappe", "latte")
    vim.g.catppuccin_flavour = "mocha" -- You can change this to your preferred flavor

    require("catppuccin").setup({
      custom_highlights = {
        -- Customize line numbers
        LineNr = { fg = "#be9225" },   -- Change line numbers to this color
        CursorLineNr = { fg = "#25be92" }, -- Change cursor line number to this color

        -- Customize comments
        Comment = { fg = "#bc8dbc", italic = true }, -- Change comment color and make it italic (optional)
      },
    })

    -- Apply the colorscheme
    vim.cmd.colorscheme("catppuccin")
  end,
}
