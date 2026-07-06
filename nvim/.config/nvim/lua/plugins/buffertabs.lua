return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
    -- jump to buffer by position
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Buffer 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Buffer 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Buffer 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Buffer 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Buffer 5" },
  },
  opts = {
    options = {
      mode = "buffers",
      -- close the buffer without touching the window layout (plain bdelete
      -- can take the whole window/nvim down with it)
      close_command = function(n) Snacks.bufdelete(n) end,
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },
      separator_style = "thin",
      show_buffer_close_icons = true,
      show_close_icon = false,
      always_show_bufferline = true,
    },
  },
}