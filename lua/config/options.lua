-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- For our Next.js project
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.wrap = false
opt.colorcolumn = "80,120"

-- Better for JSX/TSX
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Recognize Prisma files
vim.filetype.add({
  extension = {
    prisma = "prisma",
  },
})
