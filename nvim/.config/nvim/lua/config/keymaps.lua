-- Space is the leader. Must be set before lazy loads.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- ============================================================
-- Core (your existing maps)
-- ============================================================

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Keep cursor centered on jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Prev search centered" })

-- Move selected lines
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- ============================================================
-- Diagnostics (global; uses nvim 0.11 jump API)
-- ============================================================

map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })

-- ============================================================
-- Nice-to-haves (adapted from Jess Archer)
-- ============================================================

-- Disable F1 help (easy to hit by accident)
map("", "<F1>", "<Nop>", { desc = "Disable F1 help" })

-- Close all open buffers
map("n", "<leader>Q", ":bufdo bdelete<cr>", { desc = "Delete all buffers" })

-- Allow gf to open non-existent files
map("", "gf", ":edit <cfile><cr>", { desc = "Edit file under cursor" })

-- Reselect visual selection after indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Maintain cursor position when yanking a visual selection
map("v", "y", "myy`y", { desc = "Yank selection, keep cursor" })
map("v", "Y", "myY`y", { desc = "Yank line, keep cursor" })

-- Move by display line when wrapped, unless a count is given
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up by display line" })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down by display line" })

-- Paste over visual selection without clobbering the register
map("v", "p", '"_dP', { desc = "Paste without yanking selection" })

-- Quick trailing semicolon / comma from insert mode
map("i", ";;", "<Esc>A;<Esc>", { desc = "Append semicolon" })
map("i", ",,", "<Esc>A,<Esc>", { desc = "Append comma" })

-- Open current file in the default macOS program
map("n", "<leader>x", ":!open %<cr><cr>", { desc = "Open current file externally" })

-- Avoid the annoying command-line window on q:
map("n", "q:", ":q<cr>", { desc = "Close command-line window" })

-- Resize windows with Ctrl + arrows
map("n", "<C-Up>", ":resize +2<cr>", { desc = "Increase height" })
map("n", "<C-Down>", ":resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-Left>", ":vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-Right>", ":vertical resize +2<cr>", { desc = "Increase width" })