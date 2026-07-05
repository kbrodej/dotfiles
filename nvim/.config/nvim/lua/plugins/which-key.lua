return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      delay = 0,
    })
    wk.add({
      { "<leader>c", group = "code/format" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "find" },
      { "<leader>l", group = "laravel" },
      { "<leader>w", group = "workspace" },
    })
  end,
}