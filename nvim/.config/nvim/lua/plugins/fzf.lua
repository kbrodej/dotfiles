return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>f",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find files",
		},
		{
			"<leader>F",
			function()
				require("fzf-lua").files({ fd_opts = "--no-ignore --hidden --type f", prompt = "All Files❯ " })
			end,
			desc = "Find all files",
		},
		{
			"<leader>b",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>g",
			function()
				require("fzf-lua").live_grep({ prompt = "Grep Project❯ " })
			end,
			desc = "Grep project",
		},
		{
			"<leader>G",
			function()
				require("fzf-lua").live_grep({
					rg_opts = "--hidden --no-ignore --column --line-number --no-heading --color=always --smart-case -g '!.git'",
					prompt = "Grep All❯ ",
				})
			end,
			desc = "Grep all files",
		},
		{
			"<leader>h",
			function()
				require("fzf-lua").help_tags()
			end,
			desc = "Help tags",
		},
		{
			"<leader>s",
			function()
				require("fzf-lua").lsp_document_symbols()
			end,
			desc = "Document symbols",
		},
		-- LSP nav (what fzf provided before)
		{
			"gd",
			function()
				require("fzf-lua").lsp_definitions()
			end,
			desc = "Go to definition",
		},
		{
			"gr",
			function()
				require("fzf-lua").lsp_references()
			end,
			desc = "Go to references",
		},
		{
			"<leader>ws",
			function()
				require("fzf-lua").lsp_live_workspace_symbols()
			end,
			desc = "Workspace symbols",
		},
		-- resume last picker (telescope users miss this; fzf has it too)
		{
			"<leader>r",
			function()
				require("fzf-lua").resume()
			end,
			desc = "Resume last search",
		},
	},
	config = function()
		local fzf = require("fzf-lua")
		local actions = require("fzf-lua").actions

		fzf.setup({
			"default-title",
			fzf_colors = true,

			-- prompt at top, ascending (matches sorting_strategy = 'ascending')
			winopts = {
				height = 0.85,
				width = 0.85,
				row = 0.35,
				preview = {
					layout = "horizontal",
					vertical = "right:60%",
					delay = 50, -- snappy preview ( timeout 200)
				},
			},

			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-d"] = "preview-page-down",
					["ctrl-u"] = "preview-page-up",
					["ctrl-p"] = "prev-history",
					["ctrl-n"] = "next-history",
				},
			},

			files = {
				prompt = "Files❯ ",
				fd_opts = "--color=never --type f --hidden --follow --exclude .git",
				path_shorten = 1, -- path_display = { truncate = 1 }
			},

			grep = {
				prompt = "Grep❯ ",
				rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --sort=path -g '!.git'",
				-- <C-space> to switch from rg to fuzzy refine
				actions = {
					["ctrl-q"] = actions.file_edit_or_qf,
				},
			},

			buffers = {
				prompt = "Buffers❯ ",
				previewer = false, -- buffers picker has previewer = false
			},

			-- lsp pickers with no preview for refs/defs
			lsp = {
				prompt = "❯ ",
				references = { previewer = false },
				definitions = { previewer = false },
				symbols = { symbol_width = 55 },
			},

			-- esc closes (<esc> = actions.close)
			fzf_opts = {
				["--info"] = "inline-right",
			},
		})

		-- register fzf-lua as the vim.ui.select handler (telescope-ui-select equivalent)
		fzf.register_ui_select()
	end,
}

