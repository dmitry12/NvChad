local hooks = require "core.hooks"

hooks.add("setup_mappings", function(map)
  -- Center when searching
  map("n", "n", "nzzzv", opt)
  map("n", "N", "Nzzzv", opt)
  map("n", "J", "mzJ`z", opt)

  -- Undo breakpoints
  map("i", ",", ",<C-g>u", opt)
  map("i", ".", ".<C-g>u", opt)
  map("i", "[", "[<C-g>u", opt)
  map("i", "]", "]<C-g>u", opt)
  map("i", "(", ")<C-g>u", opt)
  map("i", "!", "!<C-g>u", opt)
  map("i", "?", "!<C-g>u", opt)
  map("i", "$", "$<C-g>u", opt)
  map("i", "_", "_<C-g>u", opt)

  map("", "j", '(v:count > 5 ? "m\'" . v:count : "") . "j"', { expr = true })
  map("", "k", '(v:count > 5 ? "m\'" . v:count : "") . "k"', { expr = true })

  -- Moving text
  map("v", "J", ":m '>+1<CR>gv=gv", opt)
  map("v", "K", ":m '<-2<CR>gv=gv", opt)

  map("i", "<C-j>", "<esc>:m .+1<CR>==i", opt)
  map("i", "<C-k>", "<esc>:m .-2<CR>==i", opt)

  map("n", "<leader>j", ":m .+1<CR>==", opt)
  map("n", "<leader>k", ":m .-2<CR>==", opt)

  map("n", "<C-Space>", ":tabe %<CR>", opt)
  map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opt)

  -- Git
  map("n", "<leader>gs", ":G<CR><C-w>15-", opt)
  map("n", "<leader>ga", ":diffget //3<CR>", opt)
  map("n", "<leader>gl", ":diffget //3<CR>", opt)


  --
  map("n", "s", ":w<CR>", opt)
end)

-- to add new plugins, use the "install_plugin" hook,
-- note: we heavily suggest using packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- examples below:

hooks.add("install_plugins", function(use)
  use {
    "tpope/vim-surround"
  }
  use {
    "tpope/vim-abolish",
  }
  use {
    "datawraith/auto_mkdir"
  }
  use { 
    "alexghergh/nvim-tmux-navigation", config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true -- defaults to false
      }

      vim.api.nvim_set_keymap('n', "<c-h>", ":lua require'nvim-tmux-navigation'.nvimtmuxnavigateleft()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<c-j>", ":lua require'nvim-tmux-navigation'.nvimtmuxnavigatedown()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<c-k>", ":lua require'nvim-tmux-navigation'.nvimtmuxnavigateup()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<c-l>", ":lua require'nvim-tmux-navigation'.nvimtmuxnavigateright()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<c-\\>", ":lua require'nvim-tmux-navigation'.nvimtmuxnavigatelastactive()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<c-space>", ":lua require'nvim-tmux-navigation'.nvimtmuxnavigatenext()<cr>", { noremap = true, silent = true })
    end
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  }
end)

require "custom.plugins.harpoon"
