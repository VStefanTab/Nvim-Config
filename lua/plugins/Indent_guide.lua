return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local ibl = require("ibl")
      ibl.setup({
        -- Your configuration options here
        -- e.g., indent = { char = "│", show_trailing_blankline_indent = false }
      })
    end,
  },
}
