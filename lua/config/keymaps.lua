-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Add these at the end of existing keymaps
map("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format code" })
map("n", "<leader>cd", require("dap").continue, { desc = "Debug: Start/Continue" })

-- search buffers
map("n", "<leader>;", "<cmd>Buffers<cr>", { desc = "Search buffers" }) -- Added desc
-- quick-save
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Quick-save" }) -- Fixed options

-- Ctrl+j and Ctrl+k as Esc
map("n", "<C-j>", "<Esc>")
map("i", "<C-j>", "<Esc>")
map("v", "<C-j>", "<Esc>")
map("s", "<C-j>", "<Esc>")
map("x", "<C-j>", "<Esc>")
map("c", "<C-j>", "<Esc>")
map("o", "<C-j>", "<Esc>")
map("l", "<C-j>", "<Esc>")
map("t", "<C-j>", "<Esc>")

-- Jump to start and end of line using the home row keys
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
-- open new file adjacent to current file
map("n", "<leader>o", ':e <C-R>=expand("%:p:h") . "/" <cr>', { desc = "Open new file adjacent to current file" }) -- Fixed options
-- no arrow keys --- force yourself to use the home row
map("n", "<up>", "<nop>")
map("n", "<down>", "<nop>")
map("i", "<up>", "<nop>")
map("i", "<down>", "<nop>")
map("i", "<left>", "<nop>")
map("i", "<right>", "<nop>")
-- make j and k move by visual line, not actual line, when text is soft-wrapped
map("n", "j", "gj", { desc = "Move down by visual line" }) -- Fixed options
map("n", "k", "gk", { desc = "Move up by visual line" }) -- Fixed options
-- handy keymap for replacing up to next _ (like in variable names)
-- map("n", "<leader>m", "ct_", { desc = "Replace up to next _" })
-- F1 is pretty close to Esc, so you probably meant Esc
map("", "<F1>", "<Esc>")
map("i", "<F1>", "<Esc>")
-- let the left and right arrows be useful: they can switch buffers
map("n", "<left>", ":bp<cr>")
map("n", "<right>", ":bn<cr>")
-- -- move through buffers
-- map("n", "H", ":bp<cr>")
map("n", "H", ":bp<cr>", { noremap = true, silent = true })
map("n", "L", ":bn<cr>", { noremap = true, silent = true })
-- <leader><leader> toggles between buffers
map("n", "<leader><leader>", "<c-^>")
map(
  "n",
  "<leader>wtl",
  ':lua print(vim.inspect(require("luasnip").get_snippet_filetypes()))',
  { desc = "Check filetype seen by luasnip" }
)
---- Typst-related
-- Open doc to watch
map(
  "n",
  "<leader>zp",
  ':silent exec "!zathura --fork " . expand("%:p:r") . ".pdf &"<cr>',
  { noremap = true, silent = true }
)
-- Typst watches current buffer for changes
map("n", "<leader>zw", ":TypstWatch<CR>", { noremap = true, silent = true, desc = "TypstWatch" })

-- crates.nvim
local crates = require("crates")
local opts = { silent = true }

map("n", "<leader>ct", crates.toggle, opts)
map("n", "<leader>cr", crates.reload, opts)

map("n", "<leader>cv", crates.show_versions_popup, opts)
map("n", "<leader>cf", crates.show_features_popup, opts)
map("n", "<leader>cd", crates.show_dependencies_popup, opts)

map("n", "<leader>cu", crates.update_crate, opts)
map("v", "<leader>cu", crates.update_crates, opts)
map("n", "<leader>cc", crates.update_all_crates, opts)
map("n", "<leader>cU", crates.upgrade_crate, opts)
map("v", "<leader>cU", crates.upgrade_crates, opts)
map("n", "<leader>cC", crates.upgrade_all_crates, opts)

map("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts)
map("n", "<leader>cX", crates.extract_crate_into_table, opts)

map("n", "<leader>cH", crates.open_homepage, opts)
map("n", "<leader>cR", crates.open_repository, opts)
map("n", "<leader>cD", crates.open_documentation, opts)
map("n", "<leader>cC", crates.open_crates_io, opts)
map("n", "<leader>cL", crates.open_lib_rs, opts)
