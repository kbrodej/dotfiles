return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    -- component that lists active LSP clients for the current buffer
    local function lsp_clients()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      if #clients == 0 then
        return ""
      end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return " " .. table.concat(names, ", ")
    end

    require("lualine").setup({
      options = {
        theme = "tokyonight",          -- you have tokyonight loaded
        globalstatus = true,           -- single statusline across splits
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          { "filename", path = 1 },    -- relative path like hers
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          { lsp_clients },             -- the LSP icon + names
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}