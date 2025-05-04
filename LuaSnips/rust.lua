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
  -- ===== Attribute Snippets =====
  s({
    trig = ";rf",
    dscr = "Feature cfg attribute",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t('#[cfg(feature = "type_bearing_ids")]')),

  s({
    trig = ";nrf",
    dscr = "Negative feature cfg attribute",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t('#[cfg(not(feature = "type_bearing_ids"))]')),

  s({
    trig = ";val",
    dscr = "Validation feature attribute",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t('#[cfg(feature = "validate")]')),

  s({
    trig = ";adc",
    dscr = "Allow dead code",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("#[allow(dead_code)]")),

  s({
    trig = ";auv",
    dscr = "Allow unused variables",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("#[allow(unused_variables)]")),

  s({
    trig = ";der",
    dscr = "Common derives",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]")),

  s({
    trig = ";tokm",
    dscr = "Tokio main attribute",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("#[tokio::main]")),

  -- ===== Test Snippets =====
  s(
    {
      trig = ";test",
      dscr = "Test function",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      #[test]
      fn <>() {
          <>
      }
      ]],
      {
        i(1, "test_name"),
        i(2),
      }
    )
  ),

  -- ===== Error Handling =====
  s({
    trig = ";anyh",
    dscr = "anyhow Result",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("anyhow::Result<()>")),

  s({
    trig = ";res",
    dscr = "Result type",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("Result<(), Box<dyn std::error::Error>>")),

  -- ===== Macros =====
  s({
    trig = ";dbg",
    dscr = "dbg! macro",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("dbg!()")),

  s({
    trig = ";println",
    dscr = "println! macro",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t('println!("{}", );')),

  -- ===== Async Patterns =====
  s(
    {
      trig = ";async",
      dscr = "Async function",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      async fn <>() -> <> {
          <>
      }
      ]],
      {
        i(1, "function_name"),
        i(2, "()"),
        i(3),
      }
    )
  ),

  -- ===== Documentation =====
  s(
    {
      trig = ";doc",
      dscr = "Documentation comment",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      /// <>
      /// <>
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  -- ===== Common Traits =====
  s({
    trig = ";default",
    dscr = "Default impl",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("impl Default for  { fn default() -> Self { todo!() } }")),

  -- ===== Lifetime Patterns =====
  s({
    trig = ";lt",
    dscr = "Lifetime parameter",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("<'a>")),

  -- ===== Iterator Patterns =====
  s(
    {
      trig = ";iter",
      dscr = "Iterator impl",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      impl<> Iterator for <> {
          type Item = <>;
          
          fn next(&mut self) -> Option<Self::Item> {
              <>
          }
      }
      ]],
      {
        i(1, "<'a>"),
        i(2, "Type"),
        i(3, "ItemType"),
        i(4),
      }
    )
  ),

  -- ===== Homomorphic Patterns =====
  s({
    trig = ";map",
    dscr = "Iterator map",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".map(|x| x)")),

  s({
    trig = ";and_then",
    dscr = "Iterator and_then",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".and_then(|x| x)")),

  s({
    trig = ";filter",
    dscr = "Iterator filter",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".filter(|x| x)")),

  s({
    trig = ";fold",
    dscr = "Iterator fold",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".fold(0, |acc, x| acc + x)")),

  -- ===== Other Common Patterns =====
  s(
    {
      trig = ";match",
      dscr = "Match expression",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      match <> {
          <> => <>,
      }
      ]],
      {
        i(1),
        i(2, "_"),
        i(3),
      }
    )
  ),

  s(
    {
      trig = ";iflet",
      dscr = "if let pattern",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      if let <> = <> {
          <>
      }
      ]],
      {
        i(1, "Some(x)"),
        i(2, "value"),
        i(3),
      }
    )
  ),

  s(
    {
      trig = ";whilelet",
      dscr = "while let pattern",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      while let <> = <> {
          <>
      }
      ]],
      {
        i(1, "Some(x)"),
        i(2, "value"),
        i(3),
      }
    )
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

  -- Dynamic struct with variable number of fields
  s(
    {
      trig = ";struct",
      dscr = "Struct with N fields",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      struct <> {
          <>
      }
      ]],
      {
        i(1, "StructName"),
        d(2, function(args)
          local count = tonumber(args[1][1]) or 2  -- Default to 2 fields if no number provided
          local nodes = {}
          for j = 1, count do
            local field_node = fmta("    <>: <>,", {
              i(1, "field_" .. j),
              i(2, "Type"),
            })
            table.insert(nodes, field_node)
            -- Add newline between fields except last one
            if j ~= count then
              table.insert(nodes, t({ "", "" }))
            end
          end
          return sn(nil, nodes)
        end, { 1 }),  -- Use first insert node as input for field count
      }
    )
  ),
}
