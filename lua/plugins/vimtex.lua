return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- This tells vimtex to use 'zathura' as its PDF viewer
    vim.g.vimtex_view_method = "zathura"

    -- This makes vimtex open the PDF viewer automatically
    -- after a successful compilation
    vim.g.vimtex_view_automatic = 1
  end,
}
