local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end
  },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        filters = {
          dotfiles = false,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          }
        }
      })
    end
  },
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            'NvimTree',
            statusline = {},
            winbar = {}
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {''}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'fileformat', 'location'},
        lualine_y = {},
        lualine_z = {'location'}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
      })
     end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      vim.cmd([[TSUpdate]])

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "make",
          "cpp",
          "lua",
          "vim",
          "javascript",
          "typescript",
          "python",
          "sql",
          "yaml",
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
      })
  end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    config = function()
      -- local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "angularls",
          "bashls",
          "clangd",
          "cmake",
          "cssmodules_ls",
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "eslint",
          "html",
          "jsonls",
          "tsserver",
          "ltex",
          "lua_ls",
          "marksman",
          "pyright",
          "sqlls",
          "rust_analyzer",
          "tailwindcss",
          "yamlls"
        },
      })

      local function on_attach(_, __)
        local wk = require("which-key")
        -- Attached LSP keymappings
        local keymappings = {
          D = { vim.lsp.buf.declaration, "Jump to declaration" },
          d = { vim.lsp.buf.definition, "Jump to definition" },
          h = { vim.lsp.buf.hover, "Display information"},
          i = { vim.lsp.buf.implementation, "List all implementations" },
          s = { vim.lsp.buf.signature_help, "Display signature information" },
          t = { vim.lsp.buf.type_definition, "Jump to type definition" },
          r = { vim.lsp.buf.rename, "Rename" } ,
          f = { vim.lsp.buf.formatting, "Format File" },
          a = { vim.lsp.buf.code_action, "Code Action"}
        }
        local prefix = { prefix = "<leader>L" }
        wk.register(keymappings, prefix)
      end

      require("mason-lspconfig").setup_handlers({
        function (server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach
          })
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          })
        end
    })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  }
})
