return {
  -- Configure mini.pairs to disable single quotes in Rust
  {
    "echasnovski/mini.pairs",
    -- Ensure this plugin is enabled (it should be by default if no other autopair plugin is chosen)
    enabled = true,
    opts = function(_, opts)
      -- Ensure the config structure exists
      opts = opts or {}
      opts.config = opts.config or {}
      opts.config.filetypes = opts.config.filetypes or {}

      -- Define overrides for the 'rust' filetype
      opts.config.filetypes.rust = opts.config.filetypes.rust or {}
      -- Set the configuration for the single quote character to nil, effectively disabling it
      opts.config.filetypes.rust["'"] = nil

      -- Debugging: You can uncomment this line to see the final config for mini.pairs
      -- print(vim.inspect(opts))

      return opts -- Return the modified options
    end,
  },
  { "lewis6991/gitsigns.nvim", enabled = true },

  -- You can add other custom plugin configurations below this line
}
