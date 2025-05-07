-- set local host for ollama
vim.g.ollama_host = "http://localhost:11434"

-- try to fix issues with aider '--watch' mode
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  command = "checktime",
})
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})

-- settings for bacon-ls
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- default settings
--
-- -- Hopefully not needed
-- require("lsp-endhints").setup({
--   icons = {
--     type = "󰜁 ",
--     parameter = "󰏪 ",
--     offspec = " ", -- hint kind not defined in official LSP spec
--     unknown = " ", -- hint kind is nil
--   },
--   label = {
--     truncateAtChars = 20,
--     padding = 1,
--     marginLeft = 0,
--     sameKindSeparator = ", ",
--   },
--   extmark = {
--     priority = 50,
--   },
--   autoEnableHints = true,
-- })
