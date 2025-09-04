-- Next.js/React specific configuration
return {
  -- Configure TypeScript server for Next.js
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "relative",
                jsxAttributeCompletionStyle = "auto",
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false, -- Too noisy
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
              },
              suggest = {
                completeFunctionCalls = true,
              },
              updateImportsOnFileMove = {
                enabled = "always",
              },
            },
            javascript = {
              preferences = {
                importModuleSpecifier = "relative",
                jsxAttributeCompletionStyle = "auto",
              },
              suggest = {
                completeFunctionCalls = true,
              },
            },
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "className\\s*:\\s*[\"'`]([^\"'`]*)[\"'`]" },
                },
              },
              validate = true,
              lint = {
                cssConflict = "warning",
                invalidTailwindDirective = "error",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
              },
            },
          },
        },
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
      },
    },
  },

  -- Auto tag for JSX/TSX
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
  },

  -- Better TypeScript errors
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact" },
    config = true,
  },

  -- Show colors in code (for Tailwind)
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "javascript", "typescript", "typescriptreact", "javascriptreact", "html" },
    opts = {
      user_default_options = {
        tailwind = true,
        css = true,
        rgb_fn = true,
        hsl_fn = true,
      },
    },
  },

  -- Package.json info - THIS IS ALL YOU NEED FOR NPM PACKAGES
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    ft = "json",
    opts = {
      colors = {
        up_to_date = "#3C4048",
        outdated = "#d19a66",
      },
      icons = {
        enable = true,
        style = {
          up_to_date = "|  ",
          outdated = "|  ",
        },
      },
      hide_up_to_date = false,
      hide_unstable_versions = false,
    },
    keys = {
      {
        "<leader>ns",
        function()
          require("package-info").show()
        end,
        desc = "Show package info",
      },
      {
        "<leader>nu",
        function()
          require("package-info").update()
        end,
        desc = "Update package",
      },
      {
        "<leader>nd",
        function()
          require("package-info").delete()
        end,
        desc = "Delete package",
      },
      {
        "<leader>ni",
        function()
          require("package-info").install()
        end,
        desc = "Install package",
      },
      {
        "<leader>np",
        function()
          require("package-info").change_version()
        end,
        desc = "Change package version",
      },
    },
  },

  -- Configure Prettier to work with our setup
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        prisma = { "prismalsp" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Configure treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "javascript",
        "html",
        "css",
        "json",
        "prisma",
        "graphql",
        "regex",
        "jsdoc",
      })
    end,
  },

  -- 🔥 ES7+ React Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node

      -- Helper to get filename
      local function filename()
        return vim.fn.expand("%:t:r")
      end

      -- ES7+ React Snippets for TypeScript
      ls.add_snippets("typescriptreact", {
        -- rafce
        s("rafce", {
          t("import React from 'react'"),
          t({ "", "", "const " }),
          f(filename),
          t(" = () => {"),
          t({ "", "  return (", "    <div>" }),
          i(1),
          t({ "</div>", "  )", "}", "", "export default " }),
          f(filename),
        }),

        -- rfce
        s("rfce", {
          t("import React from 'react'"),
          t({ "", "", "function " }),
          f(filename),
          t("() {"),
          t({ "", "  return (", "    <div>" }),
          i(1),
          t({ "</div>", "  )", "}", "", "export default " }),
          f(filename),
        }),

        -- useState
        s("useState", {
          t("const ["),
          i(1, "state"),
          t(", set"),
          i(2, "State"),
          t("] = useState("),
          i(3),
          t(")"),
        }),

        -- useEffect
        s("useEffect", {
          t({ "useEffect(() => {", "  " }),
          i(1),
          t({ "", "}, [" }),
          i(2),
          t("])"),
        }),
      })

      -- Also add snippets to JavaScript files
      ls.add_snippets("javascriptreact", ls.get_snippets("typescriptreact"))

      -- Setup Tab navigation
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          return "<Tab>"
        end
      end, { silent = true, expr = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },

  -- 🔥 Open in GitHub (useful for checking docs)
  {
    "almo7aya/openingh.nvim",
    cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
  },

  -- ❌ REMOVED cmp-npm - IT WAS CAUSING THE ERROR
  -- The package-info.nvim plugin above already handles everything we need
}
