-- File: ~/.config/nvim/lua/plugins/nuru.lua
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- This ensures your ftplugins load when you open a .nr file
      vim.filetype.add({
        extension = {
          nr = "nuru",
          sw = "nuru",
          sr = "nuru",
        },
      })
    end,
    opts = {
      servers = {
        nuru_lsp = {
          cmd = { vim.fn.expand("~/nuru-lsp/nuru-lsp") },
          filetypes = { "nuru" },
          root_dir = require("lspconfig.util").root_pattern(".git", "main.nr"),
        },
      },
    },
    config = function(_, opts)
      -- Standard lazyvim/lspconfig setup logic usually goes here
      -- or you can manually setup:
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs["nuru_lsp"] then
        configs["nuru_lsp"] = { default_config = opts.servers.nuru_lsp }
      end
      lspconfig.nuru_lsp.setup({})
    end,
  },
}
