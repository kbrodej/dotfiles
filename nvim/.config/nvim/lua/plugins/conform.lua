return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        php = { "pint" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        blade = { "blade-formatter" },
        lua = { "stylua" },
      },
      format_on_save = function(bufnr)
        -- let you toggle format-on-save off per-buffer or globally
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 2000, lsp_format = "fallback" }
      end,
      formatters = {
        pint = {
          -- prefer the project's local Pint if present, else global
          command = function(self, ctx)
            local local_pint = ctx.dirname .. "/vendor/bin/pint"
            -- walk up to find vendor/bin/pint
            local found = vim.fs.find("vendor/bin/pint", {
              upward = true,
              path = ctx.dirname,
              type = "file",
            })[1]
            return found or "pint"
          end,
          args = { "$FILENAME" },
          stdin = false,
        },
      },
    })

    -- commands to toggle autoformat
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = "Disable autoformat-on-save", bang = true })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable autoformat-on-save" })
  end,
}