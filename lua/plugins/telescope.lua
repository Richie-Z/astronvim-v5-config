---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  -- version = false,
  opts = {
    defaults = {
      file_ignore_patterns = {
        ".git",
        "dist",
        "node_modules",
        "vendor",
        "yarn.lock",
      },
    },
  },
}
