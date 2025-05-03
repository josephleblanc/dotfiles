-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.filetype.add({
  extension = {
    py = "python", -- Map .py files to the 'python' filetype
    rs = "rust", -- Map .rs files to the 'rust' filetype
    lua = "lua",
  },
})

-- Autocmds for Python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 4 -- Add these, since they are common python settings
    vim.bo.shiftwidth = 4
  end,
})

-- Autocmds for Typst
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.treesitter.stop({ "highlight" }, vim.api.nvim_get_current_buf())
    -- I think it sets these automatically
    -- vim.bo.expandtab = true
    -- vim.bo.tabstop = 2 -- Add these, since they are common python settings
    -- vim.bo.shiftwidth = 2
  end,
})

-- Autocmds for Rust
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    -- Inlay hints are managed by rustaceanvim
  end,
})

-- Autocmds for Lua

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

-- Autocmds for markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.b.autoformat = false
  end,
})
