---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "pug" })
      end
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "pug_ls" })
    end,
  },

  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = {
      config = {
        pug_ls = {
          cmd = { "pug-lsp", "--stdio" },
          filetypes = { "pug" },
          root_dir = function(fname) return require("lspconfig.util").root_pattern("package.json", ".git")(fname) end,
        },
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed or {}, { "pug-lsp", "prettier" })
      local lspconfig = require "lspconfig"
      lspconfig.pug.setup {}
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup {
        format_on_save = {
          timeout_ms = 1000,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          pug = { "prettier" },
        },
      }
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, { "prettier" })
    end,
  },
}
