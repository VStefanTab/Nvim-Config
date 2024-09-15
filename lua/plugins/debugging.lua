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

			-- DAP UI and Go setup
			require("dapui").setup()
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
				vim.cmd("Neotree open")
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				ui.close()
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
			vim.keymap.set("n", "DE", function()
				dap.terminate()
				dap.repl.close()
				ui.close()
				vim.cmd("Neotree open")
			end)
		end,
	},
}
