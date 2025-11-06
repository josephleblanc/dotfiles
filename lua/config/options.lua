-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- vim.g.lazyvim_rust_diagnostics = "bacon-ls"
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
-- Leave existing settings, add:
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.history = 1000
opt.undolevels = 10000
opt.undoreload = 10000

opt.cmdheight = 1
opt.showmode = true

-- Attempting to stop snacks.nvim from crashing nvim
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.undofile = true

-- NOTE: Attempting to stop crashes:
vim.g.autoformat = true

-- Disable LSP inlay hints at the lowest level
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
--   end,
-- })
vim.diagnostic.config({
  virtual_text = false,
})
