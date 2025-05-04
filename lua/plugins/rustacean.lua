-- return {
--
--   {
--     "mrcjkb/rustaceanvim",
--     version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
--     ft = { "rust" },
--     opts = {
--       server = {
--         on_attach = function(_, bufnr)
--           vim.keymap.set("n", "<leader>ra", function()
--             vim.cmd.RustLsp("hover")
--           end, { desc = "Code Action", buffer = bufnr })
--           vim.keymap.set("n", "<leader>dr", function()
--             vim.cmd.RustLsp("debuggables")
--           end, { desc = "Rust Debuggables", buffer = bufnr })
--         end,
--         default_settings = {
--           -- rust-analyzer language server configuration
--           ["rust-analyzer"] = {
--             cargo = {
--               allFeatures = true,
--               loadOutDirsFromCheck = true,
--               buildScripts = {
--                 enable = true,
--               },
--               checkOnSave = true,
--               diagnostics = {
--                 enable = true,
--               },
--             },
--             -- Add clippy lints for Rust if using rust-analyzer
--             -- checkOnSave = diagnostics == "rust-analyzer",
--             checkOnSave = diagnostics == "rust-analyzer",
--             -- Enable diagnostics if using rust-analyzer
--             diagnostics = {
--               enable = diagnostics == "rust-analyzer",
--             },
--             procMacro = {
--               enable = true,
--               ignored = {
--                 ["async-trait"] = { "async_trait" },
--                 ["napi-derive"] = { "napi" },
--                 ["async-recursion"] = { "async_recursion" },
--               },
--             },
--             files = {
--               excludeDirs = {
--                 ".direnv",
--                 ".git",
--                 ".github",
--                 ".gitlab",
--                 "bin",
--                 "node_modules",
--                 "target",
--                 "venv",
--                 ".venv",
--               },
--             },
--           },
--         },
--       },
--     },
--     config = function(_, opts)
--       if LazyVim.has("mason.nvim") then
--         local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
--         local codelldb = package_path .. "/extension/adapter/codelldb"
--         local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
--         local uname = io.popen("uname"):read("*l")
--         if uname == "Linux" then
--           library_path = package_path .. "/extension/lldb/lib/liblldb.so"
--         end
--         opts.dap = {
--           adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
--           tools = {
--             runnables = {
--               use_telescope = true, -- Better UI for selecting runnables
--             },
--             cargo_commands = {
--               cargo_command = "cargo", -- Enable custom cargo wrapper
--               use_telescope = true,
--             },
--           },
--         }
--       end
--       vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
--       if vim.fn.executable("rust-analyzer") == 0 then
--         LazyVim.error(
--           "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
--           { title = "rustaceanvim" }
--         )
--       end
--     end,
--   },
-- }

return {
  {
    "mrcjkb/rustaceanvim",
    version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
    ft = { "rust" },
    -- Use a function for opts to make it conditional
    opts = function()
      local base_opts = {} -- Start with base options if any are always needed

      -- Only configure the 'server' part if we are NOT using bacon-ls
      if diagnostics ~= "bacon-ls" then
        base_opts.server = {
          on_attach = function(_, bufnr)
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
            -- Grouped Code Action
            -- :RustLsp expandMacro
            vim.keymap.set("n", "<leader>re", function()
              vim.cmd.RustLsp("expandMacro")
            end, { desc = "Rust: Expand Macro" })
            vim.keymap.set("n", "<leader>rj", function()
              vim.cmd.RustLsp("joinLines")
            end, { desc = "Rust: Join Lines" })
            vim.keymap.set("n", "<leader>rh", function()
              vim.cmd.RustLsp("hover")
            end, { desc = "Rust: Hover Actions" })
            vim.keymap.set("n", "<leader>rm", function()
              vim.cmd.RustLsp("parentModule")
            end, { desc = "Rust: Parent Module" })
            vim.keymap.set("n", "<leader>rx", function()
              vim.cmd.RustLsp("ssr")
            end, { desc = "Rust: Structural Search Replace" })
            -- <leader>uh is mapped by Snacks to Toggle Inlay Hints
            vim.keymap.set("n", "<leader>rd", function()
              vim.cmd.RustLsp("openDocs")
            end, { desc = "Rust: Open Documentation" })
            vim.keymap.set("n", "<leader>rD", function()
              vim.cmd.RustLsp("openCargo")
            end, { desc = "Rust: Open Cargo.toml" })
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true, loadOutDirsFromCheck = true, buildScripts = { enable = true } },
              -- Ensure these are true if rust-analyzer IS the provider
              checkOnSave = false,
              diagnostics = { enable = true },
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
        }
      end

      -- DAP configuration is handled in the 'config' function, so no need to add it here.
      -- Add any other non-server opts here if needed.

      return base_opts
    end,
    config = function(_, opts)
      -- DAP configuration logic (remains the same as your original)
      if LazyVim.has("mason.nvim") then
        local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
        local codelldb = package_path .. "/extension/adapter/codelldb"
        local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
        local uname = io.popen("uname"):read("*l")
        if uname == "Linux" then
          library_path = package_path .. "/extension/lldb/lib/liblldb.so"
        end
        -- Ensure opts.dap exists before adding adapter to it
        opts.dap = opts.dap or {}
        opts.dap.adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path)
        -- Add tools config for DAP here, ensuring structure is correct
        opts.dap.tools = {
          runnables = { use_telescope = true },
          cargo_commands = { cargo_command = "cargo", use_telescope = true },
        }
      end

      -- Apply the potentially modified opts
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})

      -- Check for rust-analyzer executable only if it's supposed to be used for LSP
      if diagnostics ~= "bacon-ls" and vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
    end,
  },
}
