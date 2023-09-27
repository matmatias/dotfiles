local M = {}

local function get_does_cfg_file_exists_in_cwd(cfg_file_pattern)
	local cwd = vim.fn.getcwd()
	local cwd_content_table =
		vim.split(vim.fn.glob(cwd .. "/*") .. "\n" .. vim.fn.glob(cwd .. "/.[^.]*"), "\n", { trimempty = true })

	for _, cwd_item in pairs(cwd_content_table) do
		local does_config_file_exists = string.match(cwd_item, cfg_file_pattern)

		if does_config_file_exists then
			return true
		end
	end

	return false
end

M.get_does_cfg_file_exists_in_cwd = get_does_cfg_file_exists_in_cwd

return M
