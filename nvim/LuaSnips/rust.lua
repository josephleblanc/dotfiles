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
  -- Is my snippets supposed to look like this?
  -- ===== Temporary Snippets =====
  s(
    {
      trig = ";npa",
      dscr = "Paranoid Args",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
        m.insert("crate::union::<>", ParanoidArgs { 
            fixture: fixture_name, 
            relative_file_path: rel_path, 
            expected_path: &["crate", "union"],
            ident: "<>", 
            item_kind: ItemKind::Union,
            expected_cfg: None,
        });
       ]],
      {
        i(1, "test_name"),
        rep(1),
      }
    )
  ),
  -- s(
  --   {
  --     trig = ";npa",
  --     dscr = "Paranoid Args",
  --     regTrig = false,
  --     priority = 100,
  --     snippetType = "autosnippet",
  --   },
  --   fmta(
  --     [[
  --       m.insert("crate::type_alias::<>", ParanoidArgs {
  --           fixture: fixture_name,
  --           relative_file_path: rel_path,
  --           expected_path: &["crate", "type_alias"],
  --           ident: "<>",
  --           item_kind: ItemKind::TypeAlias,
  --           expected_cfg: None,
  --       });
  --       m.insert("crate::type_alias::<>", ExpectedTypeAliasNode {
  --           name: "<>",                       // same as key path ending
  --           visibility: VisibilityKind::<>, // usually Public
  --           type_id_check: true,            // t/f, hanlde more specific elsewhere
  --           generic_params_count: <>,       // basic check, more detailed elsehwere
  --           attributes: vec![<>],           // usually empty, otherwise vec of &'static str
  --           docstring: <>,                  // usually empty (None)
  --           tracking_hash_check: true,      // usually true, handle more specific checks in other tests
  --           cfgs: vec![<>]                  // usually empty
  --       });
  --      ]],
  --     {
  --       i(1, "test_name"),
  --       rep(1),
  --       rep(1),
  --       rep(1),
  --       i(2, "Public"),
  --       i(3, "0"),
  --       i(4),
  --       i(5, "None"),
  --       i(6),
  --     }
  --   )
  -- ),
  s(
    {
      trig = ";ptest",
      dscr = "Paranoid Test Macro",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
paranoid_test_setup!(
    test_type_alias_<>,
    "crate::type_alias::<>",
    EXPECTED_TYPE_ALIASES_ARGS,
    EXPECTED_TYPE_ALIASES_DATA,
    syn_parser::parser::nodes::TypeAliasNode,
    syn_parser::parser::nodes::ExpectedTypeAliasNode,
    as_type_alias,
    LOG_TEST_TYPE_ALIAS
);
       ]],
      {
        i(1, "setup_name"),
        i(2, "NodeName"),
      }
    )
  ),
  -- ===== Attribute Snippets =====
  s({
    trig = ";rf",
    dscr = "Feature cfg attribute",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t('#[cfg(feature = "llm_refactor")]')),
  s({
    trig = ";nrf",
    dscr = "Negative feature cfg attribute",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t('#[cfg(not(feature = "llm_refactor"))]')),

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
    async fn <>() ->> <> {
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
  s(
    {
      trig = ";default",
      dscr = "Default impl",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta( -- Use fmta for placeholders
      [[
impl Default for <> {
    fn default() ->> Self {
        <>
}
]],
      {
        i(1, "TypeName"),
        i(2, "todo!()"),
      }
    )
  ),
  -- ===== New Error Handling Snippets =====
  s(
    {
      trig = ";unwrap",
      dscr = "unwrap with expect message",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.unwrap_or_else(|<>| panic!("<>", <>))]], {
      i(1, "e"),
      i(2, "Error: {}"),
      r(1),
    })
  ),

  --   s(
  --     {
  --       trig = ";err",
  --       dscr = "Custom error type",
  --       regTrig = false,
  --       priority = 100,
  --       snippetType = "autosnippet",
  --     },
  --     fmta(
  --       [[
  -- #[derive(Debug, thiserror::Error)]
  -- enum <> {
  --     #[error("<>")]
  --     <>(<>),
  -- }
  -- ]],
  --       {
  --         i(1, "Error"),
  --         i(2, "error message"),
  --         i(3, "Variant"),
  --         i(4, "String"),
  --       }
  --     )
  --   ),

  -- ===== New Async Patterns =====
  s(
    {
      trig = ";spawn",
      dscr = "Spawn async task",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[tokio::spawn(async { <> });]], {
      i(1),
    })
  ),

  -- ===== New Testing Snippets =====
  s(
    {
      trig = ";bench",
      dscr = "Benchmark test",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
#[bench]
fn <>() {
    <>
}
]],
      {
        i(1, "bench_name"),
        i(2),
      }
    )
  ),

  -- ===== New Common Traits =====
  s(
    {
      trig = ";frm",
      dscr = "From trait implementation",
      -- regTrig = false,
      -- priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
   impl From<<<>>> for <> {
    fn from(value: <>) ->> Self {
        <>
    }
   }
   ]],
      {
        i(1, "FromType"),
        i(2, "ToType"),
        r(1),
        i(3),
      }
    )
  ),
  --------- INCORRECT VERSION KEPT FOR REFERENCE -------
  --- The problem with this version is the line:
  -- impl From<<>> for <> {
  -- The core issue is the `From<<>>`, because the escape characters for the `<`
  -- and `>` symbols is just repeating them, e.g. `<<` becomes `<`, and `>>` becomes `>`,
  -- meaning that `<<>>` becomes `<>` in the snippet output, not a jump point.
  -- Therefore the correct version reads
  --    `From<<<>>>`
  -- resulting in
  --    `From<FromType>`
  -- in the snippet output, where `FromType` is a placeholder jump value.
  --
  --   s(
  --     {
  --       trig = ";from",
  --       dscr = "From trait implementation",
  --       regTrig = false,
  --       priority = 100,
  --       snippetType = "autosnippet",
  --     },
  --     fmta(
  --       [[
  -- impl From<<>> for <> {
  --     fn from(value: <>) ->> Self {
  --         <>
  --     }
  -- }
  -- ]],
  --       {
  --         i(1, "FromType"),
  --         i(2, "ToType"),
  --         r(1),
  --         i(4),
  --       }
  --     )
  --   ),
  ------------- END INCORRECT ------------------------

  -- ===== New Macros =====
  s(
    {
      trig = ";vec",
      dscr = "Vec with capacity",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[Vec::with_capacity(<>)<>]], {
      i(1, "capacity"),
      i(2),
    })
  ),

  -- ===== New Documentation =====
  s(
    {
      trig = ";mod",
      dscr = "Module documentation",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
//! <>
//! 
//! <>
]],
      {
        i(1, "Module summary"),
        i(2, "Detailed description"),
      }
    )
  ),

  -- ===== New Iterator Patterns =====
  s(
    {
      trig = ";find",
      dscr = "Iterator find",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.find(|<>| <>)]], {
      i(1, "x"),
      i(2),
    })
  ),

  -- ===== New Smart Pointers =====
  s(
    {
      trig = ";arc",
      dscr = "Arc with Mutex",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[Arc::new(Mutex::new(<>))]], {
      i(1),
    })
  ),

  -- ===== New Serde Patterns =====
  s({
    trig = ";serde",
    dscr = "Serde derives",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t("#[derive(serde::Serialize, serde::Deserialize)]")),

  -- ===== Lifetime Patterns =====
  s({
    trig = ";lt([a-z])", -- Only matches lowercase letters after ;lt
    dscr = "Lifetime parameter with lowercase letter",
    regTrig = true,
    priority = 100,
    snippetType = "autosnippet",
  }, {
    f(function(_, snip)
      return string.format("<'%s>", snip.captures[1])
    end),
  }),
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

       fn next(&mut self) ->> Option<<Self::Item>> {
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
  s(
    {
      trig = ".map ",
      dscr = "Iterator map",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.map(|<>| <>)]], {
      i(1, "x"),
      i(2),
    })
  ),

  s(
    {
      trig = ";and_then",
      dscr = "Iterator and_then",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.and_then(|<>| <>)]], {
      i(1, "x"),
      i(2),
    })
  ),

  s(
    {
      trig = ";filter",
      dscr = "Iterator filter",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.filter(|<>| <>)]], {
      i(1, "x"),
      i(2),
    })
  ),

  s(
    {
      trig = ";fold",
      dscr = "Iterator fold",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.fold(<>, |<>| <>)]], {
      i(1, "0"),
      i(2, "acc, x"),
      i(3, "acc + x"),
    })
  ),

  -- ===== Iterator Patterns =====
  s(
    {
      trig = ";collect",
      dscr = "Collect iterator into collection",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    -- NOTE: Uses the `<<<>>>` to become a snippet reading:
    --  .collect::Vec<T>()
    -- Where `Vec` and `T` are separate jump placeholders
    fmta([[.collect::<><<<>>>()]], {
      i(1, "Vec"),
      i(2, "T"),
    })
  ),

  s(
    {
      trig = ";partition",
      dscr = "Partition iterator into two collections",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.partition(|<>| <>)]], {
      i(1, "x"),
      i(2),
    })
  ),

  s(
    {
      trig = ";take_while",
      dscr = "Take while predicate is true",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.take_while(|<>| <>)]], {
      i(1, "x"),
      i(2),
    })
  ),

  s(
    {
      trig = ";skip_while",
      dscr = "Skip while predicate is true",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.skip_while(|<>| <>)]], {
      i(1, "x"),
      i(2),
    })
  ),

  s(
    {
      trig = ";zip",
      dscr = "Zip with another iterator",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.zip(<>.into_iter())]], {
      i(1, "other_iter"),
    })
  ),

  s({
    trig = ";enumerate",
    dscr = "Add index to iterator",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".enumerate()")),

  s({
    trig = ";rev",
    dscr = "Reverse iterator",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".rev()")),

  s({
    trig = ";cycle",
    dscr = "Cycle iterator endlessly",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".cycle()")),

  s({
    trig = ";peekable",
    dscr = "Make iterator peekable",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".peekable()")),

  s({
    trig = ";fuse",
    dscr = "Fuse iterator after first None",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".fuse()")),

  -- ===== Functional Patterns =====
  -- ===== Functional Patterns =====
  s(
    {
      trig = ".mor ",
      dscr = "Option/Result map_or",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.map_or(<>, |<>| <>)]], {
      i(1, "default"),
      i(2, "x"),
      i(3),
    })
  ),

  s(
    {
      trig = ".moe ",
      dscr = "Option/Result map_or_else",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[.map_or_else(|| <>, 
    |<>| <>)]],
      {
        i(1, "default"),
        i(2, "x"),
        i(3),
      }
    )
  ),

  s(
    {
      trig = ";ok_or",
      dscr = "Option to Result conversion",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.ok_or(<>)]], {
      i(1, "Error"),
    })
  ),

  s(
    {
      trig = ".fm ",
      dscr = "Iterator flat_map",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.flat_map(|<>| <>)]], {
      i(1, "x"),
      i(2),
    })
  ),
  s({
    trig = ".fl ",
    dscr = "Iterator flatten",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, t(".flatten()")),
  s(
    {
      trig = ";chain",
      dscr = "Iterator chain",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[.chain(<>)]], {
      i(1, "iter"),
    })
  ),

  s(
    {
      trig = ";clot",
      dscr = "Closure with type annotation",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[|<>: <>| ->> <> { <> }]], {
      i(1, "x"),
      i(2, "Type"),
      i(3, "ReturnType"),
      i(4),
    })
  ),
  -- s(
  --   {
  --     trig = "([^%a])clo ",
  --     dscr = "Closure with type annotation",
  --     regTrig = true,
  --     priority = 100,
  --     snippetType = "autosnippet",
  --   },
  --   fmta([[|<>| { <> }]], {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     i(1, "x"),
  --     i(2, "todo!()"),
  --   })
  -- ),

  s(
    {
      trig = ";do",
      dscr = "Monadic do notation (using ? operator)",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
     let <> = <>?;
     <>
     ]],
      {
        i(1, "value"),
        i(2),
        i(3),
      }
    )
  ),

  s(
    {
      trig = ";match_guard",
      dscr = "Match arm with guard",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
     <> if <> =>> <>,
     ]],
      {
        i(1, "Pattern"),
        i(2, "condition"),
        i(3),
      }
    )
  ),

  -- s(
  --   {
  --     trig = ";hof",
  --     dscr = "Higher order function",
  --     regTrig = false,
  --     priority = 100,
  --     snippetType = "autosnippet",
  --   },
  --   fmta(
  --     [[
  --    fn <><<F>>(f: F) ->> <>
  --    where
  --        F: Fn(<>) ->> <>,
  --    {
  --        <>
  --    }
  --    ]],
  --     {
  --       i(1, "higher_order_fn"),
  --       i(2, "ReturnType"),
  --       i(3, "InputType"),
  --       i(4, "OutputType"),
  --       i(5),
  --     }
  --   )
  -- ),

  -- ===== Other Common Patterns =====
  s(
    {
      trig = ";marm",
      dscr = "Match arm",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      <> =>> <>,
  }
  ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s(
    {
      trig = "iflet",
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
      trig = "whilelet",
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

  -- s(
  --   { trig = ";an", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  --   fmta(
  --     [[// ANCHOR: <>
  -- <>
  -- //ANCHOR_END: <>]],
  --     {
  --       i(2),
  --       d(1, get_visual),
  --       r(2),
  --     }
  --   )
  -- ),
  -- Dynamic struct with N fields, using regex capture from trigger ";structN"
  --   Okay, reflecting on the process to arrive at the working dynamic struct snippet, here are the most important rules and principles that proved crucial:
  --
  -- 1.  **`fmta` Escaping is Strict:** Literal `<` and `>` characters within the
  --     multi-line string passed to `fmta` *must* be escaped as `<<` and `>>`
  --     respectively (e.g., `->` becomes `->>`). Failure to do so prevents the
  --     snippet file from loading.
  -- 2.  **Dynamic Input Source Matters:**
  --     *   When a snippet uses `regTrig = true` and the dynamic part depends on
  --     the trigger text, use `snip.captures[n]` inside the dynamic (`d`) or
  --     function (`f`) node's function to access the captured groups.
  --     *   When the dynamic part depends on the content of *another node*
  --     within the same snippet (and `regTrig` might be false), use the `args`
  --     parameter in the dynamic function and specify the dependency index
  --     (e.g., `d(..., function(args, snip) ... end, {dependency_index})`).
  -- 3.  **Dynamic Node (`d`) Return Structure is Critical:**
  --     *   When a dynamic node function needs to generate *multiple* child
  --     nodes (especially multiple `insert nodes`), it **must return a single
  --     `snippetNode` object**. The most reliable way discovered here is
  --     `return sn(nil, {list_of_child_nodes})`. Returning a raw Lua list
  --     (`{...}`) directly caused loading errors (`resolve_child_ext_opts`).
  -- 4.  **Simplicity Inside Dynamic Nodes:**
  --     *   The list of nodes *inside* the `sn(nil, {...})` returned by the
  --     dynamic function should ideally consist of **basic node types** like
  --     `i(...)` and `t(...)`. Avoid generating complex nested structures
  --     (like nodes created by `fmta`) *within* the dynamic function itself,
  --     as this seemed to contribute to loading errors.
  -- 5.  **Indexing for Dynamic Insert Nodes (`i`):**
  --     *   When generating multiple `insert nodes` (`i`) within the list
  --     returned by a dynamic node (via `sn(nil, {...})`), **start their
  --     indices from 1** (e.g., `i(1, ...)`, `i(2, ...)`). LuaSnip appears to
  --     correctly renumber these relative to the parent snippet's nodes,
  --     integrating them into the overall jump sequence. Using high or
  --     arbitrary indices caused issues with jump points.
  -- 6.  **Manual Outer Structure for Complex Dynamics:**
  --     *   For snippets involving significant dynamic generation, defining the
  --     main snippet structure as a **manual Lua list of nodes** (`s(..., {
  --     t(...), i(1, ...), d(2, ...), t(...) })`) can be more robust and
  --     easier to debug than nesting the dynamic node deeply within an `fmta`
  --     call.
  --
  -- Following these rules, particularly regarding the precise return structure
  -- and internal indexing of the dynamic node, was key to resolving the
  -- loading errors and achieving the desired dynamic behavior with correct
  -- jump points.
  s(
    {
      trig = ";struct(%d+)",
      dscr = "Struct with N fields (from trigger)",
      regTrig = true,
      priority = 100,
      snippetType = "autosnippet",
    },
    -- Build the outer structure manually
    {
      t("struct "),
      i(1, "StructName"), -- Outer index 1
      t(" {"),
      t({ "", "" }),
      d(2, function(_, snip) -- Outer index 2 (dynamic node)
        local count = tonumber(snip.captures[1]) or 0
        local nodes = {}
        -- Start placeholder indices for nodes *inside* d from 1
        local placeholder_idx = 1

        if count == 0 then
          table.insert(nodes, t("    // No fields or invalid trigger"))
          table.insert(nodes, t({ "", "" }))
        else
          for j = 1, count do
            -- Indentation
            table.insert(nodes, t("    "))
            -- Field name - Use index placeholder_idx (starts at 1)
            table.insert(nodes, i(placeholder_idx, "field_" .. j))
            -- Colon and Type
            table.insert(nodes, t(": "))
            -- Type - Use index placeholder_idx + 1 (starts at 2)
            table.insert(nodes, i(placeholder_idx + 1, "Type"))
            -- Comma
            table.insert(nodes, t(","))
            -- Newline
            table.insert(nodes, t({ "", "" }))

            -- Increment for the next pair of inner insert nodes
            placeholder_idx = placeholder_idx + 2
          end
        end
        -- Still return sn(nil, nodes) as that structure loaded correctly
        return sn(nil, nodes)
      end),
      -- Closing brace
      t("}"),
    }
  ),
  -- Dynamic enum with N variants, using regex capture from trigger ";enumN"
  s(
    {
      trig = ";enum(%d+)",
      dscr = "Enum with N variants (name + optional type)",
      regTrig = true,
      priority = 100,
      snippetType = "autosnippet",
    },
    -- Build the outer structure manually
    {
      t("enum "),
      i(1, "EnumName"), -- Outer index 1: Enum Name
      t(" {"),
      t({ "", "" }), -- Opening brace and newline
      d(2, function(_, snip) -- Outer index 2: Dynamic node for variants
        local count = tonumber(snip.captures[1]) or 0
        local nodes = {}
        local placeholder_idx = 1

        if count == 0 then
          table.insert(nodes, t("    // No variants or invalid trigger"))
          table.insert(nodes, t({ "", "" }))
        else
          for j = 1, count do
            table.insert(nodes, t("    "))
            table.insert(nodes, i(placeholder_idx, "Variant" .. j))
            table.insert(nodes, t("("))
            table.insert(nodes, i(placeholder_idx + 1, "Type"))
            table.insert(nodes, t("),"))
            table.insert(nodes, t({ "", "" }))
            placeholder_idx = placeholder_idx + 2
          end
        end
        return sn(nil, nodes)
      end),
      -- Closing brace
      t("}"),
      -- *** Explicit final jump point i(0) after the snippet ***
      i(0),
    }
  ),

  -- Dynamic enum with N repeated variants (Corrected: Sequential outer indices)
  s(
    {
      trig = ";enumr(%d+)",
      dscr = "Enum with N repeated variants",
      regTrig = true,
      priority = 100,
      snippetType = "autosnippet",
    },
    -- Manual outer structure with sequential jump indices
    {
      t("enum "),
      i(1, "EnumName"), -- Outer index 1
      t(" {"),
      t({ "", "" }),

      -- Define the FIRST variant directly here with sequential indices
      t("    "),
      i(2, "Variant"), -- Outer index 2
      t("("),
      i(3, "Type"), -- Outer index 3
      t("),"),
      t({ "", "" }),

      -- Dynamic node ONLY generates the repetitions, comes after i(3)
      d(4, function(_, snip) -- Outer index 4
        local num_to_repeat = (tonumber(snip.captures[1]) or 1) - 1
        local nodes = {}

        -- Check if repetitions are needed before looping
        if num_to_repeat > 0 then
          -- Loop index '_' signifies it's intentionally unused
          for _ = 1, num_to_repeat do
            table.insert(nodes, t("    "))
            -- Repeat Variant Name (referencing outer i(2))
            table.insert(nodes, r(2))
            table.insert(nodes, t("("))
            -- Repeat Type (referencing outer i(3))
            table.insert(nodes, r(3))
            table.insert(nodes, t("),"))
            table.insert(nodes, t({ "", "" }))
          end
        end
        -- Return the single snippetNode containing the flat list of repetitions
        return sn(nil, nodes)
      end, { 1 }), -- Depend on capture group 1 from trigger

      -- Closing brace
      t("}"),
      -- Explicit final jump point i(0) after the snippet
      i(0),
    }
  ),
  -- Dynamic function signature with N arguments
  s(
    {
      trig = ";fn(%d+)",
      dscr = "Function signature with N arguments",
      regTrig = true,
      priority = 100,
      snippetType = "autosnippet",
    },
    -- Manual outer structure
    {
      t("fn "),
      i(1, "function_name"), -- Outer index 1: Function Name
      t("("),
      d(2, function(_, snip) -- Outer index 2: Dynamic arguments
        local count = tonumber(snip.captures[1]) or 0
        local nodes = {}
        local placeholder_idx = 1 -- Inner indices start at 1

        if count > 0 then
          for j = 1, count do
            table.insert(nodes, i(placeholder_idx, "arg" .. j))
            table.insert(nodes, t(": "))
            table.insert(nodes, i(placeholder_idx + 1, "Type"))
            if j < count then
              table.insert(nodes, t(", "))
            end
            placeholder_idx = placeholder_idx + 2
          end
        end
        return sn(nil, nodes)
      end),
      -- No escape needed for -> in t()
      t(") -> "),
      -- Jump point for return type (index > dynamic args)
      i(101, "()"),
      t(" {"),
      t({ "", "" }),
      t("    "),
      -- Jump point for function body (index > return type)
      i(102, "todo!()"),
      t({ "", "" }),
      t("}"),
    }
  ),
  -- Dynamic match expression with N arms (Corrected Again)
  s(
    {
      trig = ";match(%d+)",
      dscr = "Match expression with N arms",
      regTrig = true,
      priority = 100,
      snippetType = "autosnippet",
    },
    -- Manual outer structure
    {
      t("match "),
      i(1, "expression"), -- Outer index 1: Expression to match
      t(" {"),
      t({ "", "" }),
      d(2, function(_, snip) -- Outer index 2: Dynamic arms
        local count = tonumber(snip.captures[1]) or 0
        local nodes = {}
        local placeholder_idx = 1 -- Inner indices start at 1

        if count > 0 then
          for j = 1, count do
            table.insert(nodes, t("    "))
            table.insert(nodes, i(placeholder_idx, "Pattern" .. j))
            table.insert(nodes, t(" => "))
            table.insert(nodes, i(placeholder_idx + 1, "result" .. j))
            -- *** REMOVED comma from inside the loop ***
            -- Comma is only needed *between* arms, handled by the catch-all below
            table.insert(nodes, t({ "", "" })) -- Add newline
            placeholder_idx = placeholder_idx + 2
          end
        end
        return sn(nil, nodes)
      end),
      -- Catch-all arm with jump point for todo!()
      t("    _ => "),
      i(101, "todo!()"),
      -- Add the comma *after* the catch-all. This separates the last dynamic
      -- arm (if any) from the catch-all, and provides the common trailing comma.
      t(","),
      t({ "", "" }),
      t("}"), -- Closing brace
    }
  ),
  -- Dynamic tuple with N elements
  s(
    {
      trig = ";tup(%d+)",
      dscr = "Tuple with N elements",
      regTrig = true,
      priority = 100,
      snippetType = "autosnippet",
    },
    -- Manual outer structure (simpler here)
    {
      t("("),
      d(1, function(_, snip) -- Outer index 1: Dynamic elements
        local count = tonumber(snip.captures[1]) or 0
        local nodes = {}
        local placeholder_idx = 1 -- Inner indices start at 1

        if count > 0 then
          for j = 1, count do
            -- Element placeholder
            table.insert(nodes, i(placeholder_idx, "val" .. j))
            -- Add comma and space if not the last element
            if j < count then
              table.insert(nodes, t(", "))
            end
            placeholder_idx = placeholder_idx + 1 -- Only one placeholder per element
          end
        end
        -- Return the single snippetNode containing the flat list
        return sn(nil, nodes)
      end),
      t(")"), -- Closing parenthesis
    }
  ),
  -- Dynamic tuple with N repeated elements based on first element
  s(
    {
      trig = ";tupr(%d+)",
      dscr = "Tuple with N repeated elements",
      regTrig = true,
      priority = 100,
      snippetType = "autosnippet",
    },
    -- Manual outer structure
    {
      t("("),
      d(1, function(_, snip) -- Outer index 1: Dynamic elements
        local count = tonumber(snip.captures[1]) or 0
        local nodes = {}

        if count > 0 then
          table.insert(nodes, i(1, "val"))
          for j = 2, count do
            table.insert(nodes, t(", "))
            table.insert(nodes, r(1))
          end
        end
        return sn(nil, nodes)
      end),
      t(")"), -- Closing parenthesis
      -- *** Explicit final jump point i(0) after the snippet ***
      i(0),
    }
  ),

  s(
    {
      trig = ";ltB",
      dscr = "Lifetime bound (where T: 'a)",
      regTrig = false,
      priority = 100,
      snippetType = "autosnippet",
    },
    fmta([[where <>: '<>,]], {
      i(1, "T"),
      i(2, "a"),
    })
  ),
}
