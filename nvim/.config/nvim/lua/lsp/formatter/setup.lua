local formatters = require("lsp.formatter.formatters")
require("mason-tool-installer").setup({
	ensure_installed = formatters,
})

-- Bash
local bash_formatter = require("formatter.filetypes.sh").shfmt
-- C
local c_formatter = require("formatter.defaults.clangformat")
-- Java
local java_formatter = require("formatter.defaults.clangformat")
-- JS/TS
local eslintd_formatter = require("formatter.defaults.eslint_d")
local prettier_formater = require("formatter.defaults.prettier")
-- local does_eslint_config_file_exists = require("lsp.formatter.utils").get_does_cfg_file_exists_in_cwd(".*eslint.*")
local jsts_formatter = prettier_formater
-- if does_eslint_config_file_exists then
-- 	jsts_formatter = eslintd_formatter
-- end
-- Python
local python_formatter = require("formatter.filetypes.python").black
-- SQL
-- local sql_linter = require("formatter.filetypes.sql").sqlfluff

local setup = {
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		sh = bash_formatter,
		c = c_formatter,
		cpp = c_formatter,
		java = java_formatter,
		javascript = jsts_formatter,
		javascriptreact = jsts_formatter,
		typescript = jsts_formatter,
		typescriptreact = jsts_formatter,
		html = prettier_formater,
		python = python_formatter,
		-- sql = sql_linter,
	},
}

return setup
