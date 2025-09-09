return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        racket_langserver = {
          cmd = { "racket", "--lib", "racket-langserver" },
          filetypes = { "scheme", "racket" },
          single_file_support = true,
        },
      },
    },
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "scheme" })
      end
    end,
  },

  -- vim-slime for REPL interaction
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "2" }
    end,
  },
}
