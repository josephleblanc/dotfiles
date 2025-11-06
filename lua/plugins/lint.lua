local HOME = os.getenv("HOME")
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", HOME .. "/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}

-- Disable all linting in markdown
-- return {
--   "mfussenegger/nvim-lint",
-- optional = true,
-- opts = {
--   linters = {
--     ["markdownlint-cli2"] = {
--       args = { "--config", "/home/pcino/.markdownlint-cli2.yaml", "--" },
--     },
--   },
-- },
-- }
