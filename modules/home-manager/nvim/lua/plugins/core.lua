return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "elixir",
        "css",
        "heex",
        "hyprlang",
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        html = {
          filetypes = { "html", "heex" },
        },
        cssls = {},
        ts_ls = {},
        elixirls = {
          settings = {
            elixirLS = {
              dialyzerEnabled = false,
              fetchDeps = false,
            },
          },
        },
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "heex", -- add heex here
          },
          init_options = {
            userLanguages = {
              elixir = "html-eex",
              heex = "html-eex",
            },
          },
          settings = {
            tailwindCSS = {
              includeLanguages = { heex = "html" },
              experimental = {
                classRegex = {
                  -- for Phoenix HEEx templates
                  'class[:]\\s*"([^"]*)"',
                  "class[:]\\s*'([^']*)'",
                  "class[:]\\s*\\[([^]]*)\\]", -- for dynamic classes
                },
              },
            },
          },
        },
        nixd = {},
        hyprls = {},
      },
    },
  },
}
