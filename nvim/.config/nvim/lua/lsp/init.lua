require("mason").setup()
local lspconfig = require("lspconfig")

local function on_attach(_, __)
	local wk = require("which-key")
	-- Attached LSP keymappings
	local keymaps = require("lsp.keymaps").lsp()
	local prefix = { prefix = "<leader>l" }
	wk.register(keymaps, prefix)
end

local function default_handler(server_name, capabilities)
	lspconfig[server_name].setup({
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
		["ltex"] = function()
			lspconfig.ltex.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "tex" },
			})
		end,
	})

	-- Formatters setup
	local formatter = require("formatter")
	local formatters_setup = require("lsp.formatter.setup")
	formatter.setup(formatters_setup)
end

return lsp
