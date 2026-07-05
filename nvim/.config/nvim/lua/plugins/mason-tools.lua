 return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "blade-formatter",
        "stylua",
      },
      run_on_start = true,
    })
  end,
}