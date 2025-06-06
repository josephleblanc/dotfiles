return {
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    enabled = true,
    config = function() -- The second argument 'opts' from LazyVim is no longer needed here
      -- Define your options directly inside the config function
      local opts = {
        icons = {
          type = "󰜁 ",
          parameter = "󰏪 ",
          offspec = " ", -- hint kind not defined in official LSP spec
          unknown = " ", -- hint kind is nil
        },
        label = {
          truncateAtChars = 20,
          padding = 1,
          marginLeft = 10,
          sameKindSeparator = ", ",
        },
        extmark = {
          priority = 50,
        },
        autoEnableHints = true,
      }

      -- Call the plugin's setup function with these locally defined options
      require("lsp-endhints").setup(opts)

      -- Set the LspEndHints highlight group to have a transparent background
    end,
    -- The top-level 'opts' key is now removed
  },
}
