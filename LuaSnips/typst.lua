-- Following Guide from https://ejmastnak.com/tutorials/vim-latex/luasnip/#files
---- Anatomy of a LuaSnip snippet
-- require("luasnip").snippet(
--     snip_params:table,  -- table of snippet parameters
--     nodes:table,        -- table of snippet nodes
--     opts:table|nil      -- *optional* table of additional snippet options
-- )
------ Examples:
---- Example of a multiline text node
-- s({trig = "lines", dscr = "Demo: a text node with three lines."},
--     {
--       t({"Line 1", "Line 2", "Line 3"})
--     }
-- ),
---- Combining text and insert nodes to create basic LaTeX commands
-- s({trig="eq", dscr="A LaTeX equation environment"},
--     fmt( -- The snippet code actually looks like the equation environment it produces.
--       [[
--         \begin{equation}
--             <>
--         \end{equation}
--       ]],
--       -- The insert node is placed in the <> angle brackets
--       { i(1) },
--       -- This is where I specify that angle brackets are used as node positions.
--       { delimiters = "<>" }
--     )
-- ),

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
  -- Dynamically sized table for typst
  -- Note: need to set hiddent to avoid errors with snip.captures not being a number type
  s(
    { trig = "([^%a])mt(%d)", regTrig = true, snippetType = "autosnippet", docTrig = "3", hidden = "true" },
    fmta(
      [[
#figure(
  table(
    align: horizon,
    columns: 3,
    table.header(
      [Known],
      [Unknown],
      [Relevant Equations]
    ),
    [$<>$], [$<>$], table.cell(rowspan: 3, align: center + horizon)[$ <> $],
    <>
  )
)
]],
      {
        i(1),
        i(2),
        i(3),
        f(function(args, snip)
          local s = "\n[$$], [$$],"
          local ret_str = string.rep(s, tonumber(snip.captures[2]))
          return vim.split(ret_str, "\n", { trimempty = false })
        end),
      }
    )
  ),

  -- surrounds for equations
  s(
    { trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- Multi-line Equations
  s(
    { trig = "([^%a])MM", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[<>
$ 
  <> 
$]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        d(1, get_visual),
      }
    )
  ),
  -- Table: Dynamic nxn table
  -- A fun zero subscript snippet
  s(
    { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("0"),
    })
  ),
  -- A fun zero subscript snippet
  s(
    { trig = "([%a%)%]%}])11", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("1"),
    })
  ),
  -- A fun zero subscript snippet
  s(
    { trig = "([%a%)%]%}])22", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("2"),
    })
  ),
  -- Fun subscripting snippet
  s(
    { trig = "([%a%)%]%}])__", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    })
  ),
  -- aligned equations
  s({ trig = "meq", snippetType = "autosnippet" }, {
    t("&="),
  }),
  -- Table: Dynamic rows (TRULY, FINALLY CORRECT!!!!!!!)

  -- Make side-panel note (using `drafting` plugin)
  s(
    { trig = "([^%a])mn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>#margin-note[<>]", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- Integrals (captures from tab)
  s(
    { trig = "([^%a])mii", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>integral_(<>)^(<>) <> ", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      d(3, get_visual),
    })
  ),
  -- derivatives in typst using physica
  s(
    { trig = "([^%a])dd(%a)", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>dd(<>) ", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      -- i(1),
      -- d(1, get_visual),
    })
  ),

  -- auto trigger example snippets
  s({ trig = ";a", snippetType = "autosnippet" }, {
    t("alpha"),
  }),
  s({ trig = ";e", snippetType = "autosnippet" }, {
    t("epsilon"),
  }),
  s({ trig = ";l", snippetType = "autosnippet" }, {
    t("lambda"),
  }),
  s({ trig = ";k", snippetType = "autosnippet" }, {
    t("kappa"),
  }),
  s({ trig = ";d", snippetType = "autosnippet" }, {
    t("delta"),
  }),
  s({ trig = ";D", snippetType = "autosnippet" }, {
    t("Delta"),
  }),
  s({ trig = ";s", snippetType = "autosnippet" }, {
    t("sigma"),
  }),
  s({ trig = ";r", snippetType = "autosnippet" }, {
    t("rho"),
  }),

  -- Rust code block
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
}
