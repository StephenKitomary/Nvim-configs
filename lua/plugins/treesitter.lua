-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- important with newer LazyVim stacks
  opts = {
    ensure_installed = {
      "javascript",
      "typescript",
      "tsx",
      "json",
      "html",
      "css",
      "lua",
    },
    highlight = { enable = true },
  },
}
