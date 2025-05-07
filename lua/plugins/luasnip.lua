return {
  "L3MON4D3/LuaSnip",
  lazy = true,
  build = (not LazyVim.is_win())
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
    or nil,
  -- dependencies table removed, friendly-snippets loaded conditionally below
  config = function()
    -- Load local snippets first
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/LuaSnips" }, -- Ensure this path points correctly to your LuaSnips directory
    })

    -- Load snippets from friendly-snippets AFTER your custom ones
    -- so your snippets can override them if needed.
    if LazyVim.has("friendly-snippets") then
      require("luasnip.loaders.from_vscode").lazy_load()
    end

    require("luasnip").config.setup({
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "●", "DiagnosticWarn" } },
          },
        },
      },
    })

    -- vim.cmd([[
    -- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    -- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
    -- imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    -- smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    -- ]])
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
