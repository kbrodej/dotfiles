-- Dashboard + QoL via snacks.
-- DDEV status line + a `d` key that toggles DDEV (start if stopped, stop if
-- running) in the background, notifying when done. fzf-lua pickers on the keys,
-- persistence.nvim session restore.

-- Resolve the ddev project name from the cwd folder.
-- (Assumes folder name == ddev project name; see note if you rename projects.)
local function ddev_project()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

-- Synchronous running check (single fast docker query).
local function ddev_running()
  local out = vim.fn.system(
    "docker ps --filter label=com.ddev.site-name="
      .. vim.fn.shellescape(ddev_project())
      .. " --format '{{.Names}}'"
  )
  return out:match("%S") ~= nil
end

-- Toggle ddev in the background, notify on completion, refresh the dashboard.
local function ddev_toggle()
  local running = ddev_running()
  local action = running and "stop" or "start"
  local cwd = vim.fn.getcwd()

  Snacks.notify.info("DDEV: " .. action .. "ing " .. ddev_project() .. "…")

  vim.system(
    { "ddev", action },
    { cwd = cwd, text = true },
    function(res)
      vim.schedule(function()
        if res.code == 0 then
          Snacks.notify.info("DDEV: " .. action .. " complete")
        else
          Snacks.notify.error("DDEV: " .. action .. " failed\n" .. (res.stderr or ""))
        end
        -- re-render dashboard so the status line updates, if it's open
        pcall(function() Snacks.dashboard.update() end)
      end)
    end
  )
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  -- global keymaps (lazy.nvim top-level field, sibling of opts)
  keys = {
    { "<leader>da", function() Snacks.dashboard() end, desc = "Open dashboard" },
  },
  opts = {
    notifier = { enabled = true, timeout = 3000 },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua require('fzf-lua').files()" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Grep", action = ":lua require('fzf-lua').live_grep()" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua require('fzf-lua').oldfiles()" },
          { icon = " ", key = "d", desc = "Toggle DDEV", action = ddev_toggle },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        -- DDEV status: whole section is a function returning an item table.
        function()
          local running = ddev_running()
          return {
            align = "center",
            padding = 1,
            text = {
              { "  DDEV: ", hl = "Comment" },
              running and { "● running", hl = "DiagnosticOk" }
                or { "○ stopped", hl = "DiagnosticError" },
            },
          }
        end,
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}