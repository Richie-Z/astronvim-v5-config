local function open_dashboard_when_no_buffer()
  local bufs = vim.fn.getbufinfo({ buflisted = true })
  require("astrocore.buffer").close(0)
  if not bufs[2] then
    require("snacks").dashboard()
  end
end

return {
  n = {
    L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
    H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
    ["<leader>c"] = {
      function() open_dashboard_when_no_buffer() end,
      desc = "Close buffer",
    },
    ["<leader>bC"] = {
      function()
        require("astrocore.buffer").close_all()
        open_dashboard_when_no_buffer()
      end,
      desc = "Close all buffers",
    },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", desc = "Window Left" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", desc = "Window Right" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", desc = "Window Down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", desc = "Window Up" },
    ["o"] = { "o<esc>", desc = "Open new line then go to normal mode" },
    ["O"] = { "O<esc>", desc = "Open new line upper then go to normal mode" },
    ["n"] = { "nzz", desc = "center cursor vertically during search" },
    ["N"] = { "Nzz", desc = "center cursor vertically during search (reverse)" },
    ["J"] = { "mzJ`z", desc = "Join line with line below" },
    ["<C-d>"] = { "<C-d>zz", desc = "Scroll screen down and center cursor" },
    ["<C-u>"] = { "<C-u>zz", desc = "Scroll screen up and center cursor" },
    ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Search and replace" },
    ["<leader>fs"] = { "<CMD>Telescope lsp_document_symbols<CR>", desc = "Show outline" },
    ["<C-p>"] = { "<cmd> Telescope find_files follow=true no_ignore=false hidden=false <CR>", desc = "Find all" },
  },

  t = {
    ["jk"] = { [[<C-\><C-n>]], desc = "Exit Terminal" },
  },
}
