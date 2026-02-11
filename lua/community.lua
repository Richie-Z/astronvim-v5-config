---@type LazySpec
local spec = {
  "AstroNvim/astrocommunity",
  -- UI
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.color.tint-nvim" },
  { import = "astrocommunity.recipes.telescope-lsp-mappings" },

  -- LSP
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.actions-preview-nvim" },

  -- Git
  { import = "astrocommunity.git.blame-nvim" },

  -- Completion

  -- Icons
  { import = "astrocommunity/icon/mini-icons" },

  -- Plugins
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.terminal-integration.vim-tmux-navigator" },
  { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },

  -- Motions
  { import = "astrocommunity.motion.flit-nvim" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.marks-nvim" },

  -- Packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.biome" },
}

if not os.getenv "SSH_TTY" then
  local local_packs = { "go", "dart", "markdown", "blade", "vue", "java", "kotlin", "bash" }
  for _, pack in ipairs(local_packs) do
    table.insert(spec, { import = "astrocommunity.pack." .. pack })
  end
end

return spec
