local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local wk = require("which-key")

vim.g.mapleader = ' '

wk.register({
  -- lsp actions
  w = { "<cmd>w<cr>", "Save File" },
  q = { "<cmd>quitall<cr>", "Quit Neovim"},
  r = { "<cmd>luafile %<cr>", "Reload File"},
  h = { "<cmd>noh<cr>", "Remove search highlight"},
  e = { "<cmd>NvimTreeToggle<cr>", "Open File Tree"},
  L = {
    name = "+LSP Actions",
    D = { vim.diagnostic.open_float, "Show diagnostic" },
    ["<S-Tab>"] = { vim.diagnostic.goto_prev, "Move to prev diagnostic" },
    ["<Tab>"] = { vim.diagnostic.goto_next, "Move to next diagnostic" },
    ["i"] = { "<cmd>LspInfo<cr>", "Lsp Information"}
  },
  -- Plugins
  p = {
    name = "+Plugins",
    s = { "<cmd>PackerSync<cr>", "Sync"},
    i = { "<cmd>PackerInstall<cr>", "Install" },
    ["S"] = { "<cmd>PackerStatus<cr>", "Status"},
    u = { "<cmd>PackerUninstall<cr>", "Uninstall"}
  },
  -- Find (telescope)
  f = { "<cmd>Telescope find_files<cr>", "Search File" },
  s = {
    name = "+Search",
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  }
}, { prefix = "<leader>" })

-- identation
map('v', '<', '<gv', opts) -- indent left
map('v', '>', '>gv', opts) -- indent right

-- line movement
map('v', 'J', ":m '>+1<CR>==gv", opts) -- swap 1 line down
map('v', 'K', ":m '<-2<CR>==gv", opts) -- swap 1 line up

-- windows
map('n', '<C-h>', '<C-w>h', opts) -- go to left window
map('n', '<C-l>', '<C-w>l', opts) -- go to right window 
map('n', '<C-j>', '<C-w>j', opts) -- go to right window 
map('n', '<C-k>', '<C-w>k', opts) -- go to right window 
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize +2<CR>', opts)
map('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-- tabs
map('n', '<C-t>', ':tabnew<CR>', opts) -- go to previous tab
map('n', '<S-h>', 'gT', opts) -- go to previous tab
map('n', '<S-l>', 'gt', opts) -- go to next tab

map('n', '<leader>e', ':NvimTreeToggle<CR>', opts) -- togle file tree
