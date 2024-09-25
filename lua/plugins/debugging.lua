return {
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim", -- Adds Mason integration for nvim-dap
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      -- DAP UI setup
      require("dapui").setup({
        layouts = {
          {
            elements = {
              { id = "breakpoints", size = 0.2 }, -- 20% of the left panel height
              { id = "stacks",      size = 0.2 }, -- 20% of the left panel height
              { id = "scopes",      size = 0.4 }, -- 40% of the left panel height
              { id = "watches",     size = 0.2 }, -- 20% of the left panel height
            },
            size = 50,                     -- Width
            position = "left",             -- Position on the left
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 7,     -- Height
            position = "bottom", -- Position at the bottom
          },
        },
        floating = {
          border = "rounded", -- Can also be 'single', 'double'
          max_height = 0.8,
          max_width = 0.5,
        },
      })
      -- Define the DapStopped sign with line highlight
      vim.fn.sign_define(
        "DapStopped",
        { text = "🔸", texthl = "LspDiagnosticsSignHint", linehl = "DapStoppedLine", numhl = "" }
      )
      -- Custom highlight groups for DAP UI
      vim.cmd([[
  highlight DapUIVariable guifg=#A9A1E1
  highlight DapUIType guifg=#C678DD
  highlight DapUIValue guifg=#E06C75
  highlight DapUIBreakpoints guifg=#E06C75
  highlight DapUIScope guifg=#56B6C2
  highlight DapStoppedLine guibg=#3c3836 guifg=#ffffff
]])
      require("dap-go").setup()

      -- Mason-nvim-dap setup
      require("mason-nvim-dap").setup({
        -- Automatically install configured debuggers
        ensure_installed = { "python", "delve", "codelldb" }, -- Specify the debuggers you want Mason to manage
        handlers = {},
      })

      -- Virtual text setup for DAP
      require("nvim-dap-virtual-text").setup({
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      })

      -- Automatically open/close DAP UI on debugging events
      dap.listeners.after.event_initialized["dapui_config"] = function()
        ui.open()
        vim.cmd("Neotree close")
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        ui.close()
        vim.cmd("Neotree toggle")
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        ui.close()
      end

      -- Event listener to centralize the cursor whenever the debugger stops at a new line(not the best but better than nothing)
      dap.listeners.after.event_stopped["centralize_cursor"] = function()
        local win_view = vim.fn.winsaveview()
        vim.api.nvim_win_set_cursor(0, { win_view.lnum, 0 }) -- Centralize on the current line
        vim.cmd("normal! zz")
      end

      -- Keymaps for debugging
      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)
      vim.keymap.set("n", "<F9>", function()
        vim.cmd("DapTerminate")
        dap.repl.close()
        ui.close()
        vim.cmd("Neotree toggle")
      end)
    end,
  },
}
