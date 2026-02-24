return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "scheme" })
      end
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        racket_langserver = {
          cmd = { "racket", "-l", "racket-langserver" },
          filetypes = { "racket", "scheme" },
          single_file_support = true,
        },
      },
    },
  },

  -- Conjure for REPL
  {
    "Olical/conjure",
    ft = { "racket", "scheme" },
    lazy = true,
    init = function()
      vim.g["conjure#log#hud#enabled"] = false
      vim.g["conjure#log#hud#passive_close_delay"] = 0
      vim.g["conjure#log#wrap"] = true
      vim.g["conjure#filetype#scheme"] = "conjure.client.racket.stdio"
    end,
  },

  -- AUTO-PAIRING (This handles brackets for you!)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Use treesitter
      enable_check_bracket_line = true,
      fast_wrap = {},
    },
  },

  -- Rainbow parentheses (keeps the colors)
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
}
