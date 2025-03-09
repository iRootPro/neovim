return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "fatih/vim-go",
  },
  config = function()
    local dap = require("dap")
    dap.set_log_level('DEBUG')

    dap.adapters = {
      go = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      },
      go_remote = {
        type = "server",
        port = "2345",
        host = "odin-app.sbmt",
      },
    }

    dap.configurations.go = {
      {
        type = "go_remote",
        name = "Attach odin",
        request = "attach",
        mode = "remote",
        substitutePath = {
          {
            from = "${workspaceFolder}",
            to = "/go/src/gitlab.sbmt.io/paas/odin",
          },
        },
        port = 2345,
        host = "odin-app.sbmt",
      },
      {
        type = "go",
        name = "Debug local",
        request = "launch",
        program = "${workspaceFolder}/cmd/app/",
      },
      {
        type = "go",
        name = "Debug local chat-auth",
        request = "launch",
        program = "${workspaceFolder}/cmd/",
      },
    }

    local dapui = require("dapui")
    vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
  -- UI Settings
		dapui.setup({
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						"scopes",
					},
					size = 0.3,
					position = "bottom",
				},
				{
					elements = {
						"repl",
						"breakpoints",
					},
					size = 0.3,
					position = "right",
				},
			},
			mappings = {
				edit = "e",
				expand = { "t", "<2-LeftMouse>" },
				remove = "d",
				repl = {},
				open = {},
				toggle = {},
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})

    require("dap-go").setup()
    -- require("dapui").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<leader>dc", dap.continue, {})
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>du", dapui.toggle, {})
  end,
}
