local formatters = require("lsp.formatter.formatters")
require("mason-tool-installer").setup({
	ensure_installed = formatters,
})

local clangd_formatter = require("formatter.defaults.clangformat")
local eslintd_formatter = require("formatter.defaults.eslint_d")
local prettier_formater = require("formatter.defaults.prettier")

local does_eslint_config_file_exists = require("lsp.formatter.utils").get_does_cfg_file_exists_in_cwd(".*eslint.*")
local jsts_formatter = prettier_formater

if does_eslint_config_file_exists then
	jsts_formatter = eslintd_formatter
end

local setup = {
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		c = clangd_formatter,
		cpp = clangd_formatter,
		javascript = jsts_formatter,
		typescript = jsts_formatter,
		javascriptreact = jsts_formatter,
		typescriptreact = jsts_formatter,
	},
}

return setup
