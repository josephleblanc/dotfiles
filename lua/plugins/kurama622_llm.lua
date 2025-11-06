return {
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      local tools = require("llm.common.tools")
      require("llm").setup({
        url = "http://localhost:8080/api/chat/completions",
        model = "bevy-adept-test",
        api_type = "openai",

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<CR>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },
        },

        -- display diff [require by action_handler]
        display = {
          diff = {
            layout = "vertical", -- vertical|horizontal split for default provider
            opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            provider = "mini_diff", -- default|mini_diff
          },
        },
        -- streaming_handler = local_llm_streaming_handler,
        app_handler = {
          CodeExplain = {
            handler = tools.flexi_handler,
            prompt = [[Can you explain the following part of the code in detail:
             [paste code section]
             Specifically:
             1. What is the purpose of this section?
             2. How does it work step-by-step?
             3. Are there any potential issues or limitations with this approach?

             You must:
             - Answer in English
             - DO NOT use Markdown formatting in your answers.
             ]],
            opts = {
              enter_flexible_window = true,
              url = "http://localhost:8080/api/chat/completions",
              model = "deepseek-coder:6.7b-instruct",
              api_type = "openai",
              nui_win_opts = { -- Add nui_win_opts to control window appearance
                border = { style = "rounded" },
                title = "Explain Code",
                -- Try adjusting these size and position options:
                width = 80, -- Adjust width (e.g., 80 columns)
                height = 15, -- Adjust height (e.g., 15 lines)
                row = "50%", -- Vertical position (e.g., 50% of screen height)
                col = "80%", -- Horizontal position (e.g., 80% of screen width, right side)
                relative = "editor", -- Position relative to the editor window
                anchor = "NW", -- Anchor to North-West corner
                -- You can explore other nui.nvim options as well
              },
            },
          },
          BevyGenerate = {
            handler = tools.qa_handler,
            prompt = [[You are an AI programming assistant for Rust programs using bevy 0.15.0.
             Your core tasks include:
             - Code quality and adherence to best practices
             - Potential bugs or edge cases
             - Performance optimizations
             - Readability and maintainability
             - Any security concerns

             You must:
             - Follow the user's requirements carefully and to the letter.
             - DO NOT use Markdown formatting in your answers.
             - Avoid wrapping the output in triple backticks.
             - The **INDENTATION FORMAT** of the optimized code remains exactly the **SAME** as the original code.
             - Write idiomatic rust code.
             - Adhere to the standards and ECS structure of 0.15.0 bevy

             When given a task:
             - ONLY OUTPUT THE RELEVANT CODE.]],
            opts = {
              url = "http://localhost:8080/api/chat/completions", -- your url - keep as chat/completions for now
              model = "bevy-adept-test",
              api_type = "openai",
              stream = true,
              component_width = "80%", -- Wider chat window
              component_height = "70%", -- Taller chat window
              query = {
                title = " Bevy Code Gen ", -- More specific title
                hl = { link = "String" }, -- Different highlight
              },
              input_box_opts = {
                size = "15%", -- Smaller input box, more space for output
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
              preview_box_opts = {
                size = "85%", -- Larger preview box
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
              nui_win_opts = {
                border = { style = "double" }, -- Different border style
                title = "Bevy Code Generation ", -- Main window title
                row = "40%", -- Adjust vertical position
                col = "center", -- Center horizontally
                relative = "editor",
                anchor = "NW",
              },
              -- Optional: Customize accept/reject key mappings if needed (defaults are Y/N)
              accept = {
                mapping = {
                  mode = "n",
                  keys = { "Y", "y" },
                },
                -- action: you can add a custom action if needed, but default accept is usually fine
              },
              reject = {
                mapping = {
                  mode = "n",
                  keys = { "N", "n" },
                },
                -- action: you can add a custom reject action if needed
              },
              close = {
                mapping = {
                  mode = "n",
                  keys = { "<esc>" },
                },
                -- action: you can add a custom close action if needed
              },
            },
            BevyRevisionSimplifiedFull = { -- New simplified app definition
              handler = tools.action_handler,
              prompt = [[You are an AI programming assistant.

Your core tasks include:
- Code quality and adherence to best practices
- Potential bugs or edge cases
- Performance optimizations
- Readability and maintainability
- Any security concerns

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- The **INDENTATION FORMAT** of the optimized code remains exactly the **SAME** as the original code.
- All non-code responses must use %s.

When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
2. Output the code in a **SINGLE** code block, being careful to only return relevant code.]],
              opts = {
                url = "http://localhost:8080/api/chat/completions",
                model = "bevy-adept-test",
                api_type = "openai",
                only_display_diff = true, -- KEY: Test with full output display
                accept = {
                  mapping = { mode = "n", keys = { "Y", "y" } },
                },
                reject = {
                  mapping = { mode = "n", keys = { "N", "n" } },
                },
                close = {
                  mapping = { mode = "n", keys = { "<esc>" } },
                },
              },
            },
          },
          BevyRevision = {
            handler = tools.action_handler, -- Use action_handler for diff views
            -- possible prompt idea
            -- - Implement improvements where possible
            prompt = [[You are an AI programming assistant for Rust programs using bevy 0.15.0.
             Your core tasks include:
             - Code quality and adherence to best practices
             - Potential bugs or edge cases
             - Performance optimizations
             - Readability and maintainability
             - Any security concerns

             You must:
             - Follow the original code's intent as much as possible.
             - DO NOT use Markdown formatting in your answers.
             - Avoid wrapping the output in triple backticks.
             - The **INDENTATION FORMAT** of the optimized code remains exactly the **SAME** as the original code.
             - Write idiomatic rust code.
             - Adhere to the standards and ECS structure of 0.15.0 bevy

             When given a task:
             - ONLY OUTPUT THE RELEVANT CODE.]],
            opts = {
              url = "http://localhost:8080/api/chat/completions", -- your url - keep as chat/completions for now
              model = "bevy-adept-test",
              api_type = "openai",
              only_display_diff = true,
              -- Optional: Customize accept/reject key mappings if needed (defaults are Y/N)
              accept = {
                mapping = {
                  mode = "n",
                  keys = { "Y", "y" },
                },
                -- action: you can add a custom action if needed, but default accept is usually fine
              },
              reject = {
                mapping = {
                  mode = "n",
                  keys = { "N", "n" },
                },
                -- action: you can add a custom reject action if needed
              },
              close = {
                mapping = {
                  mode = "n",
                  keys = { "<esc>" },
                },
                -- action: you can add a custom close action if needed
              },
            },
          },
          ChatApp = { -- Using qa_handler for chat with streaming
            handler = tools.qa_handler, -- Use qa_handler
            prompt = "Start chatting below:", -- Initial system prompt (you can customize this)
            opts = {
              url = "http://localhost:8080/api/chat/completions", -- Your API URL
              model = "deepseek-coder:6.7b-instruct", -- Your model
              api_type = "openai", -- Your API type
              stream = true, -- Ensure streaming is enabled (should be default for qa_handler, but explicit is better)
              component_width = "70%", -- Adjust width of the whole chat window
              component_height = "60%", -- Adjust height of the whole chat window
              query = { -- Options for the input box title
                title = " LLM Chat ", -- Title of the input box
                hl = { link = "Comment" }, -- Highlight link for the title
              },
              input_box_opts = { -- Options for the input box
                size = "20%", -- Height of the input box as a percentage of component_height
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- Window highlight
                },
              },
              preview_box_opts = { -- Options for the preview/output box
                size = "80%", -- Height of the preview box
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- Window highlight
                },
              },
              nui_win_opts = { -- Optional: Overall nui.nvim window options (for position, border, etc.)
                border = { style = "rounded" },
                title = "LLM Chat App (QA Handler)", -- Title of the main window
                row = "50%",
                col = "50%",
                relative = "editor",
                anchor = "NW",
              },
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
      { "<leader>lx", mode = "v", "<cmd>LLMSelectedTextHandler CodeExplain<cr>" },
      { "<leader>lbg", mode = "n", "<cmd>LLMAppHandler BevyGenerate<cr>" },
      { "<leader>lbr", mode = "v", "<cmd>LLMAppHandler BevyRevision<cr>" },
      { "<leader>lC", mode = "n", "<cmd>LLMAppHandler ChatApp<cr>" }, -- NEW keybinding for ChatApp
      { "<leader>lbF", mode = "v", "<cmd>LLMAppHandler BevyRevisionSimplifiedFull<cr>" }, -- Keybinding for simplified full test
    },
  },
}
