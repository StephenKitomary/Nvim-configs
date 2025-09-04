local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Format on save (with better error handling)
local format_group = augroup("FormatOnSave", { clear = true })
autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.css", "*.json" },
  callback = function(args)
    -- Check if buffer is valid
    local buftype = vim.bo[args.buf].buftype
    if buftype ~= "" then
      return
    end

    -- Format with conform
    require("conform").format({
      bufnr = args.buf,
      lsp_fallback = true,
      quiet = true,
    })
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Auto create dir when saving file (FIXED VERSION)
autocmd("BufWritePre", {
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end

    -- Use vim.uv instead of vim.loop (for Neovim 0.10+)
    -- Or use a more compatible approach
    local file = event.match
    local dir = vim.fn.fnamemodify(file, ":p:h")

    -- Check if directory exists
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
