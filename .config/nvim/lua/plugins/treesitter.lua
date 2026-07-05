return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({
      "php", "blade", "vue", "javascript", "typescript",
      "html", "css", "json", "lua", "sql",
      "markdown", "markdown_inline",
    })

    -- Blade filetype detection (also in autocmds.lua; harmless if duplicated)
    vim.filetype.add({
      pattern = { [".*%.blade%.php"] = "blade" },
    })

    -- enable highlighting + indentation per filetype
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "php", "blade", "vue", "javascript", "typescript",
        "html", "css", "json", "lua", "sql", "markdown",
      },
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}