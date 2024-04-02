local keymaps = {}

function keymaps.lsp()
	local _keymaps = {
		D = { vim.lsp.buf.declaration, "Jump to declaration" },
		d = { vim.lsp.buf.definition, "Jump to definition" },
		h = { vim.lsp.buf.hover, "Display information" },
		i = { vim.lsp.buf.implementation, "List all implementations" },
		s = { vim.lsp.buf.signature_help, "Display signature information" },
		t = { vim.lsp.buf.type_definition, "Jump to type definition" },
		R = { vim.lsp.buf.rename, "Rename Symbol" },
		r = { vim.lsp.buf.references, "List all references" },
		Z = { "<cmd>LspRestart<cr>", "Restart" },
		f = { vim.lsp.buf.formatting, "Format File" },
		a = { vim.lsp.buf.code_action, "Code Action" },
		-- Diagnostics
		["<S-Tab>"] = { vim.diagnostic.goto_prev, "Move to prev diagnostic" },
		["<Tab>"] = { vim.diagnostic.goto_next, "Move to next diagnostic" },
		e = { vim.diagnostic.open_float, "Show Full Diagnostic" },
	}

	return _keymaps
end

function keymaps.cmp(cmp)
	local _keymaps = {
		["<C-K>"] = cmp.mapping.scroll_docs(-4),
		["<C-J>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	}

	return _keymaps
end

return keymaps
