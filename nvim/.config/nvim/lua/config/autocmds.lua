-- Blade filetype detection (moved out of the plugin file)
vim.filetype.add({
  pattern = { [".*%.blade%.php"] = "blade" },
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})

-- 2-space indent for web frontend filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vue", "javascript", "typescript", "json", "html", "css", "blade" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})