-- set local host for ollama
vim.g.ollama_host = "http://localhost:11434"

-- try to fix issues with aider '--watch' mode
vim.opt.autoread = true

-- Replace the old checktime autocmd with this more robust version:
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  -- It's good practice to put user-defined autocmds in a group
  group = vim.api.nvim_create_augroup("UserCheckTime", { clear = true }),
  callback = function(args)
    -- Check if we are in the command-line window; if so, do nothing.
    -- vim.fn.mode(true) returns a string like "c" for command-line mode, "n" for normal, etc.
    if vim.fn.mode(true):sub(1, 1) == "c" then
      return
    end

    -- Check if the buffer associated with the event (args.buf) is a "normal" file buffer.
    -- vim.bo[args.buf].buftype will be an empty string for normal buffers.
    -- We also check if the buffer is listed (vim.fn.buflisted(args.buf) == 1)
    -- to avoid running on special unlisted buffers.
    if vim.bo[args.buf].buftype == "" and vim.fn.buflisted(args.buf) == 1 then
      -- Only if these conditions are met, run checktime.
      -- Using vim.cmd to execute Ex commands.
      vim.cmd("checktime")
    end
  end,
  desc = "Run checktime for normal file buffers, avoiding command-line and special buffers",
})

-- settings for bacon-ls
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

-- Trying to fix a bug in snacks.explorer.actions that is causing crashes.
local ok, _ = pcall(function()
  require("snacks.explorer.actions").fn()
end)
if not ok then
  vim.notify("Snacks operation failed (swap file conflict?)", vim.log.levels.WARN)
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
