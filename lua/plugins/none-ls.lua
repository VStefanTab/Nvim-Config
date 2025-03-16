return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--column-width", "80" },
        }),
        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--print-width", "80" },
        }),
        null_ls.builtins.formatting.black.with({
          extra_args = { "--line-length", "80" },
        }),
        null_ls.builtins.formatting.isort,
      },
    })

    vim.keymap.set("n", "<A-F>", vim.lsp.buf.format, {})
  end,
}
