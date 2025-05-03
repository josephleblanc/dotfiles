return {
  "L3MON4D3/LuaSnip",
  lazy = true,
  build = (not LazyVim.is_win())
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
    or nil,
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
    },
  },
  config = function()
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnips/" })
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    require("luasnip").config.setup({
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    })
    -- Yes, we're just executing a bunch of Vimscript, but this is the officially
    -- endorsed method; see https://github.com/L3MON4D3/LuaSnip#keymaps
    vim.cmd([[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]])
    -- My snippets directory
    -- -- TODO: Someday organize snippets into subfo-- Two ways to load snippets from both LuaSnip1 and LuaSnip2
    -- -- 1. Using a table
    -- require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip1/", "~/.config/nvim/LuaSnip2/" } })
    -- -- 2. Using a comma-separated list
    -- require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip1/,~/.config/nvim/LuaSnip2/"})lders as needed:
  end,
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
}

-- return {
--   "L3MON4D3/LuaSnip",
--   opts = function()
--     LazyVim.cmp.actions.snippet_forward = function()
--       if require("luasnip").jumpable(1) then
--         vim.schedule(function()
--           require("luasnip").jump(1)
--         end)
--         return true
--       end
--     end
--     LazyVim.cmp.actions.snippet_stop = function()
--       if require("luasnip").expand_or_jumpable() then -- or just jumpable(1) is fine?
--         require("luasnip").unlink_current()
--         return true
--       end
--     end
--   end,
-- }
