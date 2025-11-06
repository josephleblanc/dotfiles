return {
  -- Language servers and tools
  "mason-org/mason.nvim",
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
      "texlab", -- LaTeX LSP (you might need to install "texlab" or similar separately)
      "marksman", -- Markdown LSP (for README files)
      "pyright",
      -- "rust-analyzer", -- Mason doesn't do well with rust-analyzer
      "typst-lsp",

      -- Debuggers
      "codelldb",
      "debugpy",
    },
  },
}
