require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "bashls", "ts_ls", "elixirls", "tailwindcss-language-server", "nixd", "vim", "lua", "vimdoc", "html", "prettier"}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
local path_to_elixirls = vim.fn.expand("~/software/elixir-ls-v0.28.0/language_server.sh")

vim.lsp.config('elixirls', {
  cmd = {path_to_elixirls},
  settings = {
    elixirLS = {
      -- I choose to disable dialyzer for personal reasons, but
      -- I would suggest you also disable it unless you are well
      -- acquainted with dialzyer and know how to use it.
      dialyzerEnabled = true,
      -- I also choose to turn off the auto dep fetching feature.
      -- It often get's into a weird state that requires deleting
      -- the .elixir_ls directory and restarting your editor.
      fetchDeps = false
    }
  }
})

vim.lsp.config('tailwindcss-language-server', {
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
            includeLanguages = {heex = "html"},
            experimental = {
                classRegex = {
                    -- for Phoenix HEEx templates
                    'class[:]\\s*"([^"]*)"',
                    'class[:]\\s*\'([^\']*)\'',
                    'class[:]\\s*\\[([^]]*)\\]', -- for dynamic classes
                },
            },
        },
    },

})


vim.lsp.config('tailwindcss', {
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
            includeLanguages = {heex = "html"},
            experimental = {
                classRegex = {
                    -- for Phoenix HEEx templates
                    'class[:]\\s*"([^"]*)"',
                    'class[:]\\s*\'([^\']*)\'',
                    'class[:]\\s*\\[([^]]*)\\]', -- for dynamic classes
                },
            },
        },
    },

})

vim.lsp.config('html', {
  filetypes = { "html", "heex" }, -- extend default
})
