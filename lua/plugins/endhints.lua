return {
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    enabled = false,
    opts = {
      icons = {
        type = "󰜁 ",
        parameter = "󰏪 ",
        offspec = " ", -- hint kind not defined in official LSP spec
        unknown = " ", -- hint kind is nil
      },
      label = {
        truncateAtChars = 20,
        padding = 1,
        marginLeft = 5,
        sameKindSeparator = ", ",
      },
      extmark = {
        priority = 50,
      },
      autoEnableHints = true,
    },
  },
}
