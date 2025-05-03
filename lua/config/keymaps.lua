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

-- crates.nvim (Note: some keys moved to avoid conflicts)
local crates = require("crates")
local opts = { silent = true }

map("n", "<leader>ct", crates.toggle, { desc = "Crates: Toggle Panel" })
map("n", "<leader>crr", crates.reload, { desc = "Crates: Reload" }) -- Moved from <leader>cr

map("n", "<leader>cv", crates.show_versions_popup, { desc = "Crates: Show Versions" })
map("n", "<leader>cff", crates.show_features_popup, { desc = "Crates: Show Features" }) -- Moved from <leader>cf
map("n", "<leader>cdd", crates.show_dependencies_popup, { desc = "Crates: Show Dependencies" }) -- Moved from <leader>cd

map("n", "<leader>cu", crates.update_crate, { desc = "Crates: Update Crate" })
map("v", "<leader>cu", crates.update_crates, { desc = "Crates: Update Crates (Visual)" })
map("n", "<leader>c C", crates.update_all_crates, { desc = "Crates: Update All Crates" }) -- Moved from <leader>cc (Note the space)
map("n", "<leader>cU", crates.upgrade_crate, { desc = "Crates: Upgrade Crate" })
map("v", "<leader>cU", crates.upgrade_crates, { desc = "Crates: Upgrade Crates (Visual)" })
map("n", "<leader>cUU", crates.upgrade_all_crates, { desc = "Crates: Upgrade All Crates" }) -- Moved from <leader>cC to avoid conflict

map("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, { desc = "Crates: Expand Plain Crate" })
map("n", "<leader>cX", crates.extract_crate_into_table, { desc = "Crates: Extract Crate Table" })

map("n", "<leader>cH", crates.open_homepage, { desc = "Crates: Open Homepage" })
map("n", "<leader>cR", crates.open_repository, { desc = "Crates: Open Repository" }) -- Kept, conflicts with default Rust Code Action
map("n", "<leader>cD", crates.open_documentation, { desc = "Crates: Open Documentation" })
map("n", "<leader>cO", crates.open_crates_io, { desc = "Crates: Open Crates.io" }) -- Moved from <leader>cC
map("n", "<leader>cL", crates.open_lib_rs, { desc = "Crates: Open Lib.rs" })

-- Testing (Neotest)
map("n", "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Test File" })
map("n", "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, { desc = "Test All (cwd)" })
map("n", "<leader>tn", function() require("neotest").run.run() end, { desc = "Test Nearest" })
map("n", "<leader>tO", function() require("neotest").summary.toggle() end, { desc = "Test Overview/Summary Toggle" })
map("n", "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, { desc = "Debug Nearest Test" })
map("n", "<leader>tA", function() require("neotest").run.attach() end, { desc = "Attach to Nearest Test" })

-- Debugging (DAP)
local dap = require("dap")
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Debug: Conditional Breakpoint" })
map("n", "<leader>di", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { desc = "Debug: Insert Log Point" })
map("n", "<leader>dR", dap.repl.open, { desc = "Debug: Open REPL" }) -- Note: <leader>dr is Rust Debuggables
map("n", "<leader>dj", dap.down, { desc = "Debug: Stack Down" })
map("n", "<leader>dk", dap.up, { desc = "Debug: Stack Up" })
map("n", "<leader>dn", dap.step_into, { desc = "Debug: Step Into" })
map("n", "<leader>du", dap.step_out, { desc = "Debug: Step Out" })
map("n", "<leader>dv", dap.step_over, { desc = "Debug: Step Over" })
-- <leader>cd is already mapped to dap.continue
map("n", "<leader>drc", dap.run_to_cursor, { desc = "Debug: Run To Cursor" })
map("n", "<leader>dK", dap.terminate, { desc = "Debug: Terminate/Kill Session" })

-- Rust (rustaceanvim) specific actions
map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, { desc = "Rust: Runnables" })
-- <leader>dr is already mapped to Rust Debuggables by LazyVim defaults
map("n", "<leader>ra", function() vim.cmd.RustLsp("codeAction") end, { desc = "Rust: Code Action (Replaces <leader>ca)" })
map("n", "<leader>re", function() vim.cmd.RustLsp("expandMacro") end, { desc = "Rust: Expand Macro" })
map("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end, { desc = "Rust: Join Lines" })
map("n", "<leader>rh", function() vim.cmd.RustLsp("hover") end, { desc = "Rust: Hover Actions" })
map("n", "<leader>rm", function() vim.cmd.RustLsp("parentModule") end, { desc = "Rust: Parent Module" })
map("n", "<leader>rx", function() vim.cmd.RustLsp("ssr") end, { desc = "Rust: Structural Search Replace" })
-- <leader>uh is mapped by Snacks to Toggle Inlay Hints
