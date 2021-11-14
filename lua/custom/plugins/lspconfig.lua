local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config

   local servers = {"html"}

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end

   lspconfig.tsserver.setup {
     on_attach = function(client, bufnr)
         attach()
         client.resolved_capabilities.document_formatting = false
         vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", {})
     end,
     flags = {
        debounce_text_changes = 150,
     },
   }

  -- from: https://github.com/marwan38/NvChad/blob/main/lua/plugins/configs/lspconfig.lua#L109

  local diagnosticls_filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
  }

  local diagnosticls_linters = {
    eslint = {
      sourceName = "eslint",
      command = "eslint_d",
      rootPatterns = { ".eslintrc.js", ".eslintrc.json", "package.json" },
      debounce = 100,
      args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
      parseJson = {
        errorsRoot = "[0].messages",
        line = "line",
        column = "column",
        endLine = "endLine",
        endColumn = "endColumn",
        message = "${message} [${ruleId}]",
        security = "severity",
      },
      securities = { [2] = "error", [1] = "warning" },
    }
  }

  lspconfig.diagnosticls.setup {
    on_attach = attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 500,
    },
    filetypes = vim.tbl_keys(diagnosticls_filetypes),
    init_options = {
      filetypes = diagnosticls_filetypes,
      linters = diagnosticls_linters,
    }
  }

end

return M
