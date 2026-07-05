return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  config = function()
    require("tiny-inline-diagnostic").setup()
    vim.diagnostic.config({ virtual_text = false }) -- let the plugin handle it
  end,
}