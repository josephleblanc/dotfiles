return {
  "kaarmu/typst.vim",
  ft = "typst",
  lazy = false,
  config = function()
    return {
      typst_conceal = 2, -- Default 0
      typst_embedded_languages = { "rs -> rust" },
      -- Following commented out with default settings
      -- typst_conceal_math=0,
    }
  end,
}

-- Options

-- g:typst_syntax_highlight: Enable syntax highlighting. Default: 1
-- g:typst_cmd: Specifies the location of the Typst executable. Default: 'typst'
-- g:typst_pdf_viewer: Specifies pdf viewer that typst watch --open will use. Default: ''
-- g:typst_conceal: Enable concealment. Default: 0
-- g:typst_conceal_math: Enable concealment for math symbols in math mode (i.e. replaces symbols with their actual unicode character). OBS: this can affect performance, see issue #64. Default: g:typst_conceal
-- g:typst_conceal_emoji: Enable concealing emojis, e.g. #emoji.alien becomes 👽. Default: g:typst_conceal
-- g:typst_auto_close_toc: Specifies whether TOC will be automatically closed after using it. Default: 0
-- g:typst_auto_open_quickfix: Specifies whether the quickfix list should automatically open when there are errors from typst. Default: 1
-- g:typst_embedded_languages: A list of languages that will be highlighted in code blocks. Typst is always highlighted. If language name is different from the syntax file name, you can use renaming, e.g. 'rs -> rust' (spaces around the arrow are mandatory). Default: []
-- g:typst_folding: Enable folding for typst heading Default: 0
-- g:typst_foldnested: Enable nested foldings Default: 1
