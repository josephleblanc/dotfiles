-- Following Guide from https://ejmastnak.com/tutorials/vim-latex/luasnip/#files

-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local r = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  -- Example: how to set snippet parameters
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig = ";rf",
      dscr = "my current refactor cfg",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    { -- Table 2: snippet nodes (don't worry about this for now---we'll cover nodes shortly)
      t('#[cfg(feature = "type_bearing_ids")]'), -- A single text node
    }
    -- Table 3, the advanced snippet options, is left blank.
  ),

  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig = ";nrf",
      dscr = "my current refactor cfg",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    { -- Table 2: snippet nodes (don't worry about this for now---we'll cover nodes shortly)
      t('#[cfg(not(feature = "type_bearing_ids"))]'), -- A single text node
    }
    -- Table 3, the advanced snippet options, is left blank.
  ),
  -- Table 3, the advanced snippet options, is left blank.

  -- Example: how to set snippet parameters
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig = ";val",
      dscr = "my current refactor cfg",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    { -- Table 2: snippet nodes (don't worry about this for now---we'll cover nodes shortly)
      t('#[cfg(feature = "validate")]'), -- A single text node
    }
    -- Table 3, the advanced snippet options, is left blank.
  ),
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig = ";adc",
      dscr = "allow dead code",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    { -- Table 2: snippet nodes (don't worry about this for now---we'll cover nodes shortly)
      t("#[allow(dead_code)]"), -- A single text node
    }
    -- Table 3, the advanced snippet options, is left blank.
  ),
  require("luasnip").snippet(
    { -- Table 1: snippet parameters
      trig = ";auv",
      dscr = "allow dead code",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    { -- Table 2: snippet nodes (don't worry about this for now---we'll cover nodes shortly)
      t("#[allow(unused_variables)]"), -- A single text node
    }
    -- Table 3, the advanced snippet options, is left blank.
  ),
  s(
    { trig = ";an", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[// ANCHOR: <>
<>
//ANCHOR_END: <>]],
      {
        i(2),
        d(1, get_visual),
        r(2),
      }
    )
  ),
  s({ trig = ";lt", dscr = "Lifetime parameter" }, t("<'a>")),
}
