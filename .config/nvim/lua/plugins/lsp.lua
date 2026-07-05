return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "intelephense", "vue_ls", "vtsls", "laravel_ls" },
        automatic_enable = false, -- we enable manually below
      })

      local caps = require("cmp_nvim_lsp").default_capabilities()

      local vue_plugin = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

      -- Intelephense
      vim.lsp.config("intelephense", {
        capabilities = caps,
        init_options = {
          licenceKey = vim.env.INTELEPHENSE_LICENCE_KEY,
        },
        settings = {
          intelephense = {
            files = { maxSize = 5000000 },
            environment = { phpVersion = "8.4.0" },
          },
        },
      })

      -- vtsls (TS + Vue hybrid)
      vim.lsp.config("vtsls", {
        capabilities = caps,
        filetypes = { "javascript", "typescript", "vue" },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_plugin,
                  languages = { "vue" },
                  configNamespace = "typescript",
                },
              },
            },
          },
        },
      })

      -- vue_ls
      vim.lsp.config("vue_ls", {
        capabilities = caps,
      })

      -- Laravel language server (Blade directives, routes, views, config)
      vim.lsp.config("laravel_ls", {
        capabilities = caps,
        filetypes = { "php", "blade" },
      })

      -- enable them
      vim.lsp.enable({ "intelephense", "vtsls", "vue_ls", "laravel_ls" })

      -- keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = function(k, fn) vim.keymap.set("n", k, fn, { buffer = ev.buf }) end
          map("K", vim.lsp.buf.hover)
          map("<leader>rn", vim.lsp.buf.rename)
          map("<leader>ca", vim.lsp.buf.code_action)
          map("gd", "<cmd>FzfLua lsp_definitions<CR>")
          map("gi", "<cmd>FzfLua lsp_implementations<CR>")
          map("gr", "<cmd>FzfLua lsp_references<CR>")
          -- map("gd", "<cmd>Telescope lsp_definitions<CR>")
          -- map("gi", "<cmd>Telescope lsp_implementations<CR>")
          -- map("gr", "<cmd>Telescope lsp_references<CR>")
          map("ga", vim.lsp.buf.code_action)
          map("<leader>d", vim.diagnostic.open_float)
        end,
      })
    end,
  },
}