return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      bacon_ls = {
        enabled = diagnostics == "bacon-ls",
      },
      rust_analyzer = { enabled = false },
    },
  },
}
