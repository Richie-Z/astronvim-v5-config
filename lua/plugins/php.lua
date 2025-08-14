---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "php", "phpdoc" })
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "php" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "phpactor", "intelephense", "php-debug-adapter" }
      )
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "intelephense" },
      },
    },
  },
  { import = "astrocommunity.pack.blade" },
  {
    "adalessa/laravel.nvim",
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
      "nvimtools/none-ls.nvim",
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = "<Leader>L"
          maps.n[prefix] = { desc = require("astroui").get_icon("Laravel", 1, true) .. "Laravel" }

          maps.n[prefix .. "a"] = { ":Laravel artisan<CR>", desc = "Artisan" }
          maps.n[prefix .. "r"] = { ":Laravel routes<CR>", desc = "Routes" }
          maps.n[prefix .. "c"] = { ":Composer<CR>", desc = "Composer" }
          maps.n[prefix .. "n"] = { ":Npm<CR>", desc = "Npm" }
          maps.n[prefix .. "y"] = { ":Yarn<CR>", desc = "Yarn" }
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { Laravel = "󰫐" } } },
    },
    event = { "VeryLazy" },
    config = true,
  },
  {
    "Bleksak/laravel-ide-helper.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = "<Leader>Li"
          maps.n[prefix] = { desc = require("astroui").get_icon("IdeHelper", 1, true) .. "Laravel Ide Helper" }

          maps.n[prefix .. "m"] = {
            function() require("laravel-ide-helper").generate_models(vim.fn.expand "%") end,
            desc = "Generate Model Info for current model",
          }
          maps.n[prefix .. "M"] = {
            function() require("laravel-ide-helper").generate_models() end,
            desc = "Generate Model Info for all models",
          }

          maps.n[prefix .. "w"] = {
            function()
              local cmd = "php artisan ide-helper:models -W "
              vim.cmd("!" .. cmd)
            end,
            desc = "Run php artisan ide-helper:models -W for current model",
          }

          maps.n[prefix .. "g"] = {
            function()
              local cmd = "php artisan ide-helper:generate"
              vim.cmd("!" .. cmd)
            end,
            desc = "Run php artisan ide-helper:generate",
          }

          maps.n[prefix .. "i"] = {
            function()
              local cmd = "~/.config/nvim/scripts/php-laravel-ide.sh"
              vim.cmd("!" .. cmd)
            end,
            desc = "Init phpactor + laravel-ide-helper",
          }
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { IdeHelper = "󱚌" } } },
    },
    opts = {
      save_before_write = true,
    },
  },
  {
    "ricardoramirezr/blade-nav.nvim",
    ft = { "blade", "php" },
  },
}
