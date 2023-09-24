local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local wk = require("which-key")

vim.g.mapleader = " "

local function toggle_debugger()
	require("dapui").toggle()
end

local function close_debugger()
	require("dapui").close()
end

wk.register({
	w = { "<cmd>w<cr>", "Save File" },
	q = { "<cmd>quitall<cr>", "Quit Neovim" },
	r = { "<cmd>luafile %<cr>", "Reload File" },
	h = { "<cmd>noh<cr>", "Remove search highlight" },
	e = { "<cmd>NvimTreeToggle<cr>", "Open File Tree" },
	-- Non-Attached LSP keymappings
	l = {
		name = "+LSP Actions",
		D = { vim.diagnostic.open_float, "Show diagnostic" },
		["<S-Tab>"] = { vim.diagnostic.goto_prev, "Move to prev diagnostic" },
		["<Tab>"] = { vim.diagnostic.goto_next, "Move to next diagnostic" },
		["i"] = { "<cmd>LspInfo<cr>", "Lsp Information" },
		f = { "<cmd>Format<cr>", "Format" },
	},
	-- Debugger
	D = {
		name = "+Debugger",
		t = { toggle_debugger, "Toggle" },
		b = { "<cmd>DapToggleBreakpoint<cr>", "Set Breakpoint" },
		c = { close_debugger, "Close" },
	},
	-- Plugins
	P = {
		name = "+Plugins",
		r = { "<cmd>Lazy reload<cr>", "Reload" },
		R = { "<cmd>Lazy restore<cr>", "Restore" },
		s = { "<cmd>Lazy sync<cr>", "Sync" },
		i = { "<cmd>Lazy install<cr>", "Install" },
		U = { "<cmd>Lazy update<cr>", "Update" },
		c = { "<cmd>Lazy Health<cr>", "Check Health" },
		h = { "<cmd>Lazy help<cr>", "Help" },
		l = { "<cmd>Lazy home<cr>", "List Plugins" },
	},
	-- Find (telescope)
	f = {
		name = "+Find",
		f = { "<cmd>Telescope find_files<cr>", "File" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
	},
	G = {
		name = "+Git",
		d = { "<cmd>DiffviewOpen<cr>", "Diff View" },
		c = { "<cmd>DiffviewClose<cr>", "Close Diff View" },
		h = { "<cmd>DiffviewFileHistory<cr>", "File History View" },
	},
}, { prefix = "<leader>" })

-- identation
map("v", "<", "<gv", opts) -- indent left
map("v", ">", ">gv", opts) -- indent right

-- line movement
map("v", "J", ":m '>+1<CR>==gv", opts) -- swap 1 line down
map("v", "K", ":m '<-2<CR>==gv", opts) -- swap 1 line up

-- windows
map("n", "<C-h>", "<C-w>h", opts) -- go to left window
map("n", "<C-l>", "<C-w>l", opts) -- go to right window
map("n", "<C-j>", "<C-w>j", opts) -- go to right window
map("n", "<C-k>", "<C-w>k", opts) -- go to right window
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize +2<CR>", opts)
map("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- tabs
map("n", "<C-t>", ":tabnew<CR>", opts) -- go to previous tab
map("n", "<S-h>", "gT", opts) -- go to previous tab
map("n", "<S-l>", "gt", opts) -- go to next tab

map("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- togle file tree
