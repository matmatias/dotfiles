require("mason").setup()

local function on_attach(_, __)
	local wk = require("which-key")
	-- Attached LSP keymappings
	local keymaps = require("lsp.keymaps").lsp()
	local prefix = { prefix = "<leader>L" }
	wk.register(keymaps, prefix)
end

local function default_handler(server_name, capabilities)
	require("lspconfig")[server_name].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

local lsp = {}

function lsp.setup()
	local mason_lspconfig = require("mason-lspconfig")
	local servers = require("lsp.servers")
	mason_lspconfig.setup({
		automatic_installation = true,
		ensure_installed = servers,
	})

	local cmp = require("cmp")
	local keymaps = require("lsp.keymaps").cmp(cmp)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert(keymaps),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "vsnip" },
		}, {
			{ name = "buffer" },
		}),
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	mason_lspconfig.setup_handlers({
		function(server_name)
			default_handler(server_name, capabilities)
		end,
		["lua_ls"] = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	})

	-- Formatters setup
	local formatters = require("lsp.formatters")
	require("mason-tool-installer").setup({
		ensure_installed = formatters,
	})
	require("formatter").setup({
		filetype = {
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
		},
	})

	-- Debuggers setup
	local debuggers = require("lsp.debuggers")
	require("mason-nvim-dap").setup({
		ensure_installed = debuggers,
	})

	local dap_per_project = require("nvim-dap-projects")

	local debug_files = {
		"./nvim-dap.lua",
		"./.nvim-dap/nvim-dap.lua",
		".nvim/nvim-dap.lua",
		"./.debug.lua",
		"./.debugger.lua",
		"./.dap",
	}

	dap_per_project.config_paths = debug_files
	dap_per_project.search_project_config()

  -- debuf_file example:
  -- local dap = require("dap")
  -- dap.adapters.lib = {
    -- type = "executable"
    -- command = "dap_binary",
    -- name = "dap_name"
  -- }
  --
  -- dap.configurations.c = {
    -- name = "file_name",
    -- type = "dap_name",
    -- request = "launch",
    -- program = "file_name",
    -- cwd = "${workspaceFolder}",
    -- stopOnEntry = false,
    -- args = {argv}
  -- },
  -- dap.configurations.c = {
    -- name = "file_name_2",
    -- type = "dap_name",
    -- request = "launch",
    -- program = "file_name_2",
    -- cwd = "${workspaceFolder}",
    -- stopOnEntry = false,
    -- args = {argv}
  -- }

	-- Debugger UI
	require("neodev").setup({
		library = { plugins = { "nvim-dap-ui" }, types = true },
	})
	require("dapui").setup()

	local dap = require("dap")
	-- C/C++/Rust
	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = "OpenDebugAD7",
	}
	-- For more dap installs, check https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

	local dapui = require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({})
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close({})
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close({})
	end
end

return lsp
