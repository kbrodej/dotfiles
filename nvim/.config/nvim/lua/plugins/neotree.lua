-- File tree sidebar

return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  keys = {
    { '<leader>n', ':Neotree reveal toggle<CR>', desc = 'Toggle file tree' },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    {
      's1n7ax/nvim-window-picker',
      opts = {
        filter_rules = {
          autoselect_one = true,
          include_current_win = false,
          bo = {
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            buftype = { 'terminal', "quickfix" },
          },
        },
        highlights = {
          statusline = {
            focused = {
              bg = '#9d7cd8',
            },
            unfocused = {
              bg = '#9d7cd8',
            },
          },
        },
      },
    },
  },
  opts = {
    close_if_last_window = true,
    hide_root_node = true,
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    source_selector = {
      winbar = true,
      statusline = false,
      separator = { left = "", right= "" },
      show_separator_on_edge = true,
      highlight_tab = "SidebarTabInactive",
      highlight_tab_active = "SidebarTabActive",
      highlight_background = "StatusLine",
      highlight_separator = "SidebarTabInactiveSeparator",
      highlight_separator_active = "SidebarTabActiveSeparator",
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function (file_path)
         -- require("neo-tree.command").execute({ action = "close" })
        end,
      }
    },
    default_component_configs = {
      indent = {
        padding = 0,
      },
      name = {
        use_git_status_colors = true,
        highlight_opened_files = true,
      },
    },
    window = {
      mappings = {
        ["<cr>"] = "open_with_window_picker",
        -- Backspace navigates up, but never above the project cwd.
        ["<bs>"] = function(state)
          local cwd = vim.fn.getcwd()
          local current = state.path
          local parent = vim.fn.fnamemodify(current, ":h")
          -- only climb if the parent is still within (or equal to) cwd
          if current ~= cwd and vim.startswith(parent, cwd) then
            require("neo-tree.sources.filesystem.commands").navigate_up(state)
          else
            vim.notify("Already at project root", vim.log.levels.INFO)
          end
        end,
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
        },
      },
      follow_current_file = {
        enabled = true,
      },
      group_empty_dirs = false
    },
  },
}