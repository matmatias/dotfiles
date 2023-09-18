local cmp = require'cmp'
local lspkind = require('lspkind')
local wk = require("which-key")

local keymappings = {
    d = { vim.lsp.buf.definition, "Jump to definition" },
    h = { vim.lsp.buf.hover, "Display information"},
    l = { vim.lsp.buf.implementation, "List all implementations" },
    s = { vim.lsp.buf.signature_help, "Display signature information" },
    t = { vim.lsp.buf.type_definition, "Jump to type definition" },
    r = { vim.lsp.buf.rename, "Rename" } ,
    f = { vim.lsp.buf.formatting, "Format File" },
    a = { vim.lsp.buf.code_action, "Code Action"}
}

local keymap_prefix = { prefix = "<leader>L" }

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  wk.register(keymappings, keymap_prefix)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}


cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      max_width = 50,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]"
      }
    })
  },

  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer', keyword_length = 3 },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['sumneko_lua'].setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "augroup" }
      }
    }
  },
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['pyright'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['sqls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig').rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

require('lspconfig')['tsserver'].setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    wk.register(keymappings, keymap_prefix)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
  flags = lsp_flags
}
