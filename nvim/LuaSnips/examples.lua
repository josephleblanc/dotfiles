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

return {
  -- example from help pages
  s("trigger_ordering", {
    t({ "After expanding, the cursor is here ->" }),
    i(1),
    t({ "", "After jumping forward twice, cursor is here ->" }),
    i(3),
    t({ "", "After jumping forward once, cursor is here ->" }),
    i(2),
    t({ "", "After jumping once more, the snippet is exited there ->" }),
    i(0),
  }),
  s("trigger_descendants", {
    i(1, "First jump"),
    t(" :: "),
    sn(2, {
      i(1, "Second jump"),
      t(" : "),
      i(2, "Third jump"),
    }),
  }),
}
