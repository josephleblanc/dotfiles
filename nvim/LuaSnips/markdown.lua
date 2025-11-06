-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- This is the `get_visual` function I've been talking about.
-- ----------------------------------------------------------------------------
-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  -- example:
  -- auto trigger example snippets
  s({ trig = ";a", snippetType = "autosnippet" }, {
    t("alpha"),
  }),

  s({ trig = ";cb", snippetType = "autosnippet" }, {
    t("☑"),
  }),
  s({ trig = ";eb", snippetType = "autosnippet" }, {
    t("☐"),
  }),

  ---- example: get_visual
  -- non-triggering in word with visual grab
  s(
    { trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  ---- Code blocks
  s(
    { trig = "([^%a])cbr", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[<>```rust
  <>
  ```<>]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        d(1, get_visual),
        i(2),
      }
    )
  ),
  -- add bullet point with checkbox
  s(
    { trig = "([^%a])abc", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[<>- [ ] <>
  ```<>]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        d(1, get_visual),
        i(2),
      }
    )
  ),
  -- get this kind of thing workin!!!
  --   s(
  --     { trig = "([^%a])codeitem", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  --     fmt(
  --       [[
  -- <details>
  --   <summary><code>Const(ItemConst)</code>  </summary>
  --
  -- ```rust,no_run,noplayground
  -- {{{{#include ../../../src/parser.rs:[] }}}}
  -- ```
  --
  -- </details>[] ]],
  --       {
  --         f(function(_, snip)
  --           return snip.captures[1]
  --         end),
  --         d(1, get_visual),
  --         i(2),
  --       },
  --       { delimiters = "[]" }
  --     )
  --   ),
  -- Cribbed table xnippet from:
  --https://github.com/yutkat/dotfiles/blob/596761e23ca4bd9c338527c0f54acf1f768ebe6e/.config/nvim/luasnip-snippets/markdown.lua#L3
  s({ trig = "table(%d+)x(%d+)", regTrig = true }, {
    d(1, function(args, snip)
      local nodes = {}
      local i_counter = 0
      local hlines = ""
      for _ = 1, snip.captures[2] do
        i_counter = i_counter + 1
        table.insert(nodes, t("| "))
        table.insert(nodes, i(i_counter, "Column" .. i_counter))
        table.insert(nodes, t(" "))
        hlines = hlines .. "|---"
      end
      table.insert(nodes, t({ "|", "" }))
      hlines = hlines .. "|"
      table.insert(nodes, t({ hlines, "" }))
      for _ = 1, snip.captures[1] do
        for _ = 1, snip.captures[2] do
          i_counter = i_counter + 1
          table.insert(nodes, t("| "))
          table.insert(nodes, i(i_counter))
          print(i_counter)
          table.insert(nodes, t(" "))
        end
        table.insert(nodes, t({ "|", "" }))
      end
      return sn(nil, nodes)
    end),
  }),
}
