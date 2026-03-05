---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      eslint = {
        filetypes = {
          "javascript",
          "javascript.jsx",
          "javascriptreact",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "vue",
        },
      },
      volar = { filetypes = { "vue" } },
    },
    formatting = {
      async = false,
      timeout_ms = 1000,
      filter = function(client)
        if vim.bo.filetype == "pug" then return client.name == "prettier" end
        return true
      end,
    },
  },
}
