-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Add these at the end of existing keymaps
map("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format code" })

-- search buffers
map("n", "<leader>;", "<cmd>Buffers<cr>", { desc = "Search buffers" }) -- Added desc

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
map("n", "<leader><leader>", "<c-^>", { noremap = true, silent = true })
-- map(
--   "n",
--   "<leader>Lf",
--   ':lua print(vim.inspect(require("luasnip").get_snippet_filetypes()))',
--   { desc = "LuaSnip: Check Filetype" } -- Renamed from <leader>wtl
-- )
-- Example keymap for unlinking the current snippet
vim.keymap.set({ "i", "s" }, "<C-e>", function()
  if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] then
    require("luasnip").unlink_current()
  else
    -- If no snippet is active, you could make <C-e> do something else,
    -- or just make it a no-op in this context.
    -- For example, to pass the key through if no snippet is active:
    -- return vim.api.nvim_replace_termcodes("<C-e>", true, false, true)
  end
end, { silent = true, expr = false, noremap = true, desc = "LuaSnip Unlink Current" })
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

vim.keymap.set(
  "v",
  "C",
  [[<Esc>:'<,'>s/\s\+$//e<CR>]],
  { desc = "Remove trailing whitespace (visual)", noremap = true }
)
-- crates.nvim (Note: some keys moved to avoid conflicts)
local crates = require("crates")
local opts = { silent = true }

map("n", "<leader>ct", crates.toggle, { desc = "Crates: Toggle Panel" })
map("n", "<leader>pr", crates.reload, { desc = "Crates: Reload" }) -- Renamed from <leader>crr

map("n", "<leader>cv", crates.show_versions_popup, { desc = "Crates: Show Versions" })
map("n", "<leader>pf", crates.show_features_popup, { desc = "Crates: Show Features" }) -- Renamed from <leader>cff
map("n", "<leader>pd", crates.show_dependencies_popup, { desc = "Crates: Show Dependencies" }) -- Renamed from <leader>cdd

map("n", "<leader>cU", crates.upgrade_crate, { desc = "Crates: Upgrade Crate" })
map("v", "<leader>cU", crates.upgrade_crates, { desc = "Crates: Upgrade Crates (Visual)" })
map("n", "<leader>pU", crates.upgrade_all_crates, { desc = "Crates: Upgrade All Crates" }) -- Renamed from <leader>cUU

map("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, { desc = "Crates: Expand Plain Crate" })
map("n", "<leader>cX", crates.extract_crate_into_table, { desc = "Crates: Extract Crate Table" })

map("n", "<leader>cH", crates.open_homepage, { desc = "Crates: Open Homepage" })
map("n", "<leader>cR", crates.open_repository, { desc = "Crates: Open Repository" }) -- Kept, conflicts with default Rust Code Action
map("n", "<leader>cD", crates.open_documentation, { desc = "Crates: Open Documentation" })
map("n", "<leader>cO", crates.open_crates_io, { desc = "Crates: Open Crates.io" }) -- Moved from <leader>cC
map("n", "<leader>cL", crates.open_lib_rs, { desc = "Crates: Open Lib.rs" })
