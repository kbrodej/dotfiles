return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    require("mason-nvim-dap").setup({
      ensure_installed = { "php" },
      automatic_installation = true,
    })

    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = {
        vim.fn.stdpath("data")
          .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
      },
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}",
        },
      },
    }

    dapui.setup({
  layouts = {
    {
      -- left sidebar
      elements = {
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
        { id = "scopes", size = 0.25 },  -- remove this line to take scopes OUT of the sidebar
      },
      size = 40,            -- width in columns
      position = "left",
    },
    {
      -- bottom row (where step controls live)
      elements = {
        { id = "repl", size = 0.5 },
        { id = "scopes", size = 0.5 },   -- scopes now in the bottom, next to repl
      },
      size = 12,            -- height in rows
      position = "bottom",
    },
  },
})

    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    local map = vim.keymap.set
    map("n", "<leader>db", dap.toggle_breakpoint)
    map("n", "<leader>dc", dap.continue)
    map("n", "<leader>do", dap.step_over)
    map("n", "<leader>di", dap.step_into)
    map("n", "<leader>du", dapui.toggle)
  end,
}