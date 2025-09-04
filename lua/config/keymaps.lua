-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ============================================
-- Your existing mappings
-- ============================================
-- Map jk to Escape in insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("v", "jk", "<ESC>", { desc = "Exit visual mode" })
map("x", "jk", "<ESC>", { desc = "Exit visual mode" })
map("s", "jk", "<ESC>", { desc = "Exit select mode" })
map("c", "jk", "<C-C>", { desc = "Exit command mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================
-- Next.js/React Development Keymaps
-- ============================================

-- Quick navigation to project folders
map("n", "<leader>pc", "<cmd>Telescope find_files cwd=src/components<cr>", { desc = "Find Components" })
map("n", "<leader>pa", "<cmd>Telescope find_files cwd=src/app<cr>", { desc = "Find App Routes" })
map("n", "<leader>pl", "<cmd>Telescope find_files cwd=src/lib<cr>", { desc = "Find Lib Files" })
map("n", "<leader>pp", "<cmd>Telescope find_files cwd=public<cr>", { desc = "Find Public Files" })
map("n", "<leader>ps", "<cmd>Telescope find_files cwd=src<cr>", { desc = "Find in Src" })

-- Quick file creation
map("n", "<leader>nc", function()
  vim.ui.input({ prompt = "Component name: " }, function(name)
    if name and name ~= "" then
      -- Create the component file
      local path = "src/components/" .. name .. ".tsx"
      local dir = vim.fn.fnamemodify(path, ":h")
      vim.fn.mkdir(dir, "p")
      vim.cmd("edit " .. path)

      -- Insert component template
      local lines = {
        'import { cn } from "@/lib/utils"',
        "",
        "interface " .. name .. "Props {",
        "  className?: string",
        "}",
        "",
        "export function " .. name .. "({ className }: " .. name .. "Props) {",
        "  return (",
        '    <div className={cn("", className)}>',
        "      <h1>" .. name .. "</h1>",
        "    </div>",
        "  )",
        "}",
      }
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      vim.cmd("w")
    end
  end)
end, { desc = "New Component" })

map("n", "<leader>np", function()
  vim.ui.input({ prompt = "Page route (e.g., dashboard or blog/[id]): " }, function(route)
    if route and route ~= "" then
      -- Create the page directory and file
      local dir = "src/app/" .. route
      vim.fn.mkdir(dir, "p")
      local path = dir .. "/page.tsx"
      vim.cmd("edit " .. path)

      -- Create page name from route
      local page_name = route:gsub("/", " "):gsub("%[", ""):gsub("%]", ""):gsub("-", " ")
      page_name = page_name:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest:lower()
      end)
      page_name = page_name:gsub(" ", "")

      -- Insert page template
      local lines = {
        "export default function " .. page_name .. "Page() {",
        "  return (",
        '    <div className="container mx-auto py-6">',
        '      <h1 className="text-3xl font-bold">' .. page_name .. "</h1>",
        "    </div>",
        "  )",
        "}",
      }
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      vim.cmd("w")
    end
  end)
end, { desc = "New Page" })

-- React snippets
map("n", "<leader>rfc", function()
  local component_name = vim.fn.expand("%:t:r")
  local lines = {
    "export default function " .. component_name .. "() {",
    "  return (",
    "    <div>",
    "      ",
    "    </div>",
    "  )",
    "}",
  }
  vim.api.nvim_put(lines, "l", true, true)
  vim.cmd("normal! 4G$i")
end, { desc = "React Function Component" })

map("n", "<leader>rfce", function()
  local component_name = vim.fn.expand("%:t:r")
  local lines = {
    "interface " .. component_name .. "Props {",
    "  ",
    "}",
    "",
    "export default function " .. component_name .. "({}: " .. component_name .. "Props) {",
    "  return (",
    "    <div>",
    "      ",
    "    </div>",
    "  )",
    "}",
  }
  vim.api.nvim_put(lines, "l", true, true)
  vim.cmd("normal! 2G$i")
end, { desc = "React Component + Props" })

map("n", "<leader>rus", function()
  vim.cmd("normal! oconst [state, setState] = useState()")
  vim.cmd("normal! $hi")
end, { desc = "useState Hook" })

map("n", "<leader>rue", function()
  local lines = {
    "useEffect(() => {",
    "  ",
    "}, [])",
  }
  vim.api.nvim_put(lines, "l", true, true)
  vim.cmd("normal! k$i")
end, { desc = "useEffect Hook" })

-- Import statements
map("n", "<leader>ii", function()
  vim.cmd("normal! ggO")
  vim.cmd("normal! iimport {  } from ''")
  vim.cmd("normal! F{la")
end, { desc = "Import Statement" })
-- Add to your keymaps.lua
map("n", "<leader>nk", function()
  vim.cmd("edit ~/Documents/notes/keymaps.md")
end, { desc = "Open Keymaps Reference" })

map("n", "<leader>nn", function()
  vim.cmd("edit ~/Documents/notes/quick-notes.md")
end, { desc = "Open Quick Notes" })

map("n", "<leader>nt", function()
  vim.cmd("edit ~/Documents/notes/todo.md")
end, { desc = "Open TODO" })

map("n", "<leader>id", function()
  vim.cmd("normal! ggO")
  vim.cmd("normal! iimport  from ''")
  vim.cmd("normal! F f a")
end, { desc = "Default Import" })

-- Run commands (using terminal)
map("n", "<leader>rd", "<cmd>split | terminal npm run dev<cr>", { desc = "Run Dev Server" })
map("n", "<leader>rb", "<cmd>!npm run build<cr>", { desc = "Build Project" })
map("n", "<leader>rl", "<cmd>!npm run lint<cr>", { desc = "Run Lint" })
map("n", "<leader>rt", "<cmd>!npm test<cr>", { desc = "Run Tests" })

-- Git commands (useful for your project)
map("n", "<leader>gc", "<cmd>!git add . && git commit -m ''<left>", { desc = "Git Commit" })
map("n", "<leader>gp", "<cmd>!git push<cr>", { desc = "Git Push" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })

-- Format manually (if auto-format is disabled)
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format File" })

-- Quick actions
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>ww", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>wa", "<cmd>wa<cr>", { desc = "Save All" })

-- Better navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Tailwind CSS class sorting (if you have rustywind installed)
map("n", "<leader>tw", "<cmd>!rustywind --write %<cr>", { desc = "Sort Tailwind Classes" })
