-- This file is for custom plugin configurations and additions

return {
  -- Configure nvim-autopairs to disable single quotes in Rust
  {
    "windwp/nvim-autopairs",
    -- You usually don't need to specify `event` unless you want to override
    -- LazyVim's default loading behavior for this plugin.
    -- event = "InsertEnter",
    opts = function(_, opts)
      -- Ensure the rules table exists
      opts.rules = opts.rules or {}

      -- Import the Rule object
      local Rule = require("nvim-autopairs.rule")

      -- Add a rule specifically for rust filetype
      -- This rule targets the single quote character (')
      -- and uses `with_ft('rust')` to apply only to rust files.
      -- `with_pair(function() return false end)` disables the pairing action.
      table.insert(opts.rules, Rule("'", "'")
        :with_ft("rust")
        :with_pair(function(opt)
            -- Return false to disable pairing for single quotes in rust files
            return false
          end)
        -- Optional: Add conditions if needed, e.g., based on syntax context
        -- :with_cond(function(opt)
        --   return true -- Apply the rule (which disables pairing)
        -- end)
      )

      -- Debugging: You can uncomment this line to see all active rules
      -- print(vim.inspect(opts.rules))

      return opts -- Return the modified options
    end,
  },

  -- You can add other custom plugin configurations below this line
  -- Example:
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   opts = { -- your gruvbox options }
  -- },

}
