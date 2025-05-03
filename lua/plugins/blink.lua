return {
  "saghen/blink.cmp",
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
  optional = true,
  opts = {
    snippets = {
      -- expand = function(snippet)
      --   require("luasnip").lsp_expand(snippet)
      -- end,
      preset = "luasnip",
    },

    completion = { ghost_text = { enabled = false } },
  },
}
