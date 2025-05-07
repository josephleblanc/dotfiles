return {
  "mrcjkb/rustaceanvim",
  version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
  ft = { "rust" },
  opts = {
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<leader>ra", function()
          vim.cmd.RustLsp("hover")
        end, { desc = "Code Action", buffer = bufnr })
        vim.keymap.set("n", "<leader>dr", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })

        vim.keymap.set(
          "n",
          "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
          function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end,
          { silent = true, buffer = bufnr }
        )
        -- Rust (rustaceanvim) specific actions
        vim.keymap.set("n", "<leader>rr", function()
          vim.cmd.RustLsp("runnables")
        end, { desc = "Rust: Runnables" })
        -- Code Action
        vim.keymap.set("n", "<leader>ra", function()
          vim.cmd.RustLsp("codeAction")
        end, { desc = "Rust: Code Action (Replaces <leader>ca)" })
        ---------- Grouped Code Action -------------
        ---
        ----------- Expand Macro -------------------
        vim.keymap.set("n", "<leader>rem", function()
          vim.cmd.RustLsp("expandMacro")
        end, { desc = "Rust: Expand Macro" })
        ---
        ------------ Rebuild Proc Macros -----------
        vim.keymap.set("n", "<leader>rpm", function()
          vim.cmd.RustLsp("rebuildProcMacros")
        end, { desc = "Rust: Rebuild Proc Macros" })
        ---
        --------------------------------------------
        vim.keymap.set("n", "<leader>j", function()
          vim.cmd.RustLsp("joinLines")
        end, { desc = "Rust: Join Lines" })
        ---
        ----------- moveItem {up|down} -------------
        --- up
        vim.keymap.set("n", "<M-k>", function()
          vim.cmd.RustLsp({ "moveItem", "up" })
        end, { desc = "Rust: Move Item Up" })
        --- down
        vim.keymap.set("n", "<M-j>", function()
          vim.cmd.RustLsp({ "moveItem", "down" })
        end, { desc = "Rust: Move Item Up" })
        ---
        --------------------------------------------
        vim.keymap.set("n", "<leader>rh", function()
          vim.cmd.RustLsp("hover")
        end, { desc = "Rust: Hover Actions" })
        ---
        --------------------------------------------
        vim.keymap.set("n", "<leader>rm", function()
          vim.cmd.RustLsp("parentModule")
        end, { desc = "Rust: Parent Module" })
        ---
        ------ Structure Search and Replace --------
        vim.keymap.set("n", "<leader>rx", function()
          vim.cmd.RustLsp("ssr")
        end, { desc = "Rust: Structural Search Replace" })
        -- Visual mode SSR using selected text as query
        vim.keymap.set("v", "<leader>rX", function()
          local selected = vim.fn.getreg('"') -- Get visually selected text
          vim.cmd.RustLsp({ "ssr", selected }) -- Pass to SSR
        end, { desc = "Rust: SSR with visual selection" })
        ---
        vim.keymap.set("n", "<leader>rd", function()
          vim.cmd.RustLsp("openDocs")
        end, { desc = "Rust: Open Documentation" })
        ---
        --------------------------------------------
        vim.keymap.set("n", "<leader>rD", function()
          vim.cmd.RustLsp("openCargo")
        end, { desc = "Rust: Open Cargo.toml" })
        ---local opts = { noremap=true, silent=true }
        --------------------------------------------
        --------- tree_climber_rust ----------------
        --------------------------------------------
        vim.api.nvim_buf_set_keymap(
          bufnr,
          "n",
          "s",
          '<cmd>lua require("tree_climber_rust").init_selection()<CR>',
          { noremap = true, silent = true }
        )
        --------------------------------------------
        vim.api.nvim_buf_set_keymap(
          bufnr,
          "x",
          "s",
          '<cmd>lua require("tree_climber_rust").select_incremental()<CR>',
          { noremap = true, silent = true }
        )
        --------------------------------------------
        vim.api.nvim_buf_set_keymap(
          bufnr,
          "x",
          "S",
          '<cmd>lua require("tree_climber_rust").select_previous()<CR>',
          { noremap = true, silent = true }
        )
        --------------------------------------------
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          hover = {
            actions = {
              enable = true,
              border = "rounded",
            },
          },
          cargo = {
            allFeatures = false,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },

          -- -- Add clippy lints for Rust if using rust-analyzer
          -- checkOnSave = diagnostics == "rust-analyzer",
          -- -- Enable diagnostics if using rust-analyzer
          -- diagnostics = {
          --   enable = diagnostics == "rust-analyzer",
          -- },
          -- Add clippy lints for Rust if using rust-analyzer
          checkOnSave = true,
          -- Enable diagnostics if using rust-analyzer
          diagnostics = {
            enable = true,
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    if LazyVim.has("mason.nvim") then
      local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
      local codelldb = package_path .. "/extension/adapter/codelldb"
      local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
      local uname = io.popen("uname"):read("*l")
      if uname == "Linux" then
        library_path = package_path .. "/extension/lldb/lib/liblldb.so"
      end
      opts.dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
      }
    end
    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    if vim.fn.executable("rust-analyzer") == 0 then
      LazyVim.error(
        "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
        { title = "rustaceanvim" }
      )
    end
  end,
}
