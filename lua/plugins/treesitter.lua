---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- disable the auto install duhhh
    opts.auto_install = false
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
    })
    opts.indent = {
      enable = true,
      disable = { "dart" },
    }
    opts.textobjects = {
      select = {
        enable = true,
        disable = { "dart" },
      },
    }
  end,
}
