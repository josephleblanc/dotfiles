return {
  "saghen/blink.cmp",
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
  optional = true,
  opts = {
    snippets = {
      -- expand = function(snippet) -- << REMOVE THIS LINE
      --  require("luasnip").lsp_expand(snippet) -- << REMOVE THIS LINE
      -- end, -- << REMOVE THIS LINE
      preset = "luasnip", -- Keep only this line inside snippets = { ... }
    },
    completion = { ghost_text = { enabled = false } },
  },
}
