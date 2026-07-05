-- Session save/restore per working directory.
-- Closes neo-tree before saving so it isn't restored as a phantom pane.
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceSavePre",
      callback = function()
        pcall(function() require("neo-tree.command").execute({ action = "close" }) end)
      end,
    })
  end,
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save session on exit" },
  },
}