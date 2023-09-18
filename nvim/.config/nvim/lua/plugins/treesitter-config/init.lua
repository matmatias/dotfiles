local wk = require("which-key")

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
      "c",
      "lua",
      "rust",
      "typescript",
      "javascript",
      "python"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  refactor = {
    highlight_definitions = {
      enable = false,
      clear_on_cursor_move = true,
    },

    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr"
      }
    },

    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>"
      }
    }
  },

  rainbow = {
    enable = true,
    disable = { "txt", "md" },
    extended_mode = true,
    max_file_lines = nil
  },

  autotag = {
    enable = true
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false
  }
}

-- comment
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('nvim-ts-autotag').setup()
