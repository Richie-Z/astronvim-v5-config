return {
  {
    "grafana/vim-alloy",
    ft = { "alloy" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alloy",
        callback = function() vim.bo.commentstring = "// %s" end,
      })
    end,
  },
}
