return {
  "folke/tokyonight.nvim",
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    -- style = "day",
    on_highlights = function(highlights, colors)
      -- highlights.Comment = { fg = "#57a5ff", italic = true } -- Light blue + italic

      highlights.LspInlayHint = {
        fg = colors.comment,
        bg = "NONE",
      }
      highlights.DiagnosticVirtualTextError = { fg = colors.error, bg = "NONE" }
      --
      -- And similarly for warn, info, hint using colors.warning, colors.info, colors.hint
      -- highlights.DiagnosticWarn = { fg = colors.warning, bg = "NONE" }
      highlights.DiagnosticVirtualTextWarn = { fg = colors.warning, bg = "NONE" }
      -- highlights.DiagnosticInfo = { fg = colors.info, bg = "NONE" }
      highlights.DiagnosticVirtualTextInfo = { fg = colors.info, bg = "NONE" }
      -- highlights.DiagnosticHint = { fg = colors.hint, bg = "NONE" }
      highlights.DiagnosticVirtualTextHint = { fg = colors.hint, bg = "NONE" }
    end,

    -- 1. **Soft Blues** (good visibility but stays cool-toned):
    --    - `#7dcfff` (bright cyan-blue)
    --    - `#7aa2f7` (default Tokyo Night blue)
    --    - `#57a5ff` (vibrant but not harsh)
    --
    -- 2. **Gentle Greens** (natural and easy on the eyes):
    --    - `#9ece6a` (Tokyo Night's green)
    --    - `#73daca` (teal-green)
    --    - `#b4f9f8` (very light cyan)
    --
    -- 3. **Warm Neutrals** (softer than pure white):
    --    - `#e0af68` (Tokyo Night gold)
    --    - `#ff9e64` (peach-orange)
    --    - `#c0caf5` (light lavender-gray)
    --
    -- 4. **Subtle Purples** (matches Tokyo Night's violet accents):
    --    - `#bb9af7` (Tokyo Night purple)
    --    - `#c099ff` (softer purple)
    --    - `#9d7cd8` (muted lavender)
    --
    -- 5. **High Visibility** (for maximum contrast when needed):
    --    - `#ffd166` (vibrant yellow)
    --    - `#41a6b5` (rich teal)
    --    - `#f7768e` (Tokyo Night pink - use sparingly)
    --
    -- **Pro Tip**: You can preview colors directly in Neovim using:
    -- ```lua
    -- :lua vim.api.nvim_set_hl(0, "Comment", { fg = "#COLORCODE" })
    -- ```
    --
    -- Replace `#COLORCODE` with any of the above. The change will be temporary until you add it to your config.
    --
    -- Would you like me to suggest a specific combination based on which Tokyo Night variant (moon/storm/night/day) you're using?
  },
  -- Optional: Ensure config runs and applies the theme
  -- config = function(_, opts)
  --  require("tokyonight").setup(opts)
  --  vim.cmd.colorscheme "tokyonight" -- or your specific style like "tokyonight-moon"
  -- end,
}
