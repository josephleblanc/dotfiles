return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = {
      auto_close = true,
      -- Simplify layout to minimum
      layout = {
        width = 30,
        position = "left",
        border = "single",
      },
    },
    -- Disable potentially problematic features
    inlay_hints = { enabled = false },
  },
  -- Add safety wrapper
  config = function(_, opts)
    local ok, snacks = pcall(require, "snacks")
    if ok then
      snacks.setup(opts)
    else
      vim.notify("Failed to load snacks.nvim", vim.log.levels.ERROR)
    end
  end,
}
