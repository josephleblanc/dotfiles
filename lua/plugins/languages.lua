return {
  -- Language servers and tools
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Formatters
      "black",
      "clang-format",
      "gofumpt",
      "stylua",

      -- LSPs (Language Servers)
      "bash-language-server",
      "clangd",
      "gopls",
      "latex-lsp", -- LaTeX LSP (you might need to install "texlab" or similar separately)
      "markdown-language-server", -- Markdown LSP (for README files)
      "pyright",
      "rust-analyzer",
      "typst-lsp",

      -- Debuggers
      "codelldb",
      "debugpy",
    },
  },

  -- Rust enhancements
  -- {
  --   "simrat39/rust-tools.nvim",
  --   ft = "rust",
  --   dependencies = "neovim/nvim-lspconfig",
  --   config = function()
  --     require("rust-tools").setup()
  --   end,
  --   options = {
  --     tools = {
  --       inlay_hints = {
  --         auto = false,
  --       },
  --     },
  --   },
  -- },
}
