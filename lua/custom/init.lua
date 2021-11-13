-- This is where your custom modules and plugins go.
-- See the wiki for a guide on how to extend NvChad

local hooks = require "core.hooks"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override("lsp", "publish_diagnostics", function(current)
  --   current.virtual_text = false;
  --   return current;
  -- end)

  -- To add new mappings, use the "setup_mappings" hook,
  -- you can set one or many mappings
  -- example below:

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

    --
    map("n", "s", ":w<CR>", opt)
  end)

    -- To add new plugins, use the "install_plugin" hook,
    -- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
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
        "DataWraith/auto_mkdir"
      }
      use { 
        "alexghergh/nvim-tmux-navigation", config = function()
        require'nvim-tmux-navigation'.setup {
          disable_when_zoomed = true -- defaults to false
      }

        vim.api.nvim_set_keymap('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-\\>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>", { noremap = true, silent = true })
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

  -- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
  -- then source it with

require "custom.plugins.harpoon"
