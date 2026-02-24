-- ============================================================================
-- 1. BOOTSTRAPPING LAZY.NVIM
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- 2. LAZY.NVIM SETUP
-- ============================================================================
require("lazy").setup({
  spec = {
    -- 🚨 IMPORTANT: Replace LazyVim's default theme setting with your preferred theme.
    -- We will define the theme in a separate plugin spec below.
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Load your custom plugins from the 'plugins' directory (e.g., plugins/webdev.lua)
    { import = "plugins" },

    -- ========================================================================
    -- 3. THEME PLUGINS (For TSX Highlighting Fix)
    -- This section adds a Tree-sitter supported Nord theme and sets it.
    -- ========================================================================
    {
      "shaunsingh/nord.nvim", -- A known Nord theme with Treesitter support
      lazy = false, -- Load immediately at startup
      priority = 1000, -- Load first
      config = function()
        -- You can configure Nord variables here if needed
        vim.g.nord_italic = true
        vim.cmd.colorscheme("nord")
      end,
    },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  -- Remove default 'tokyonight' install, as we are explicitly setting 'nord' above
  install = { colorscheme = { "nord", "habamax" } },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
