-- Example: Find the spec for telescope, likely in lua/plugins/telescope.lua or similar
return {
  {
    "nvim-telescope/telescope.nvim",
    -- dependencies, opts, config, etc. might be here

    -- Add or modify the 'keys' table/function:
    keys = {
      -- This explicitly tells lazy.nvim NOT to create this keymap
      -- for this plugin specification. Your mapping in keymaps.lua
      -- will then be the only one active.
      { "<leader><leader>", false },

      -- You can keep other default keys enabled or add others:
      -- { "<leader>ff", lazyvim.plugins.lsp.format, desc = "Find Files" }, -- Example if you want this
      -- ... other key mappings for telescope ...

      -- If the extra already defines keys using a function, you'll need
      -- to adapt the function to filter out the <leader><leader> mapping.
      -- Example:
      -- keys = function(plugin, keys)
      --   local new_keys = {}
      --   for _, key in ipairs(keys) do
      --     -- If the key is NOT <leader><leader>, keep it
      --     if key[1] ~= "<leader><leader>" then
      --       table.insert(new_keys, key)
      --     end
      --   end
      --   -- Add any other custom keys if needed
      --   -- table.insert(new_keys, { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" })
      --   return new_keys
      -- end,
    },
    -- ... rest of the telescope spec ...
  },
  -- ... other plugins ...
}
