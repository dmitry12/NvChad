local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  -- lspservers with default config

  -- local servers = { "html", "cssls", "pyright" }
  local servers = {"tsserver"}

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }
  end

  -- from: https://github.com/marwan38/NvChad/blob/main/lua/plugins/configs/lspconfig.lua#L109

  local diagnosticls_filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
    php = "phpcs",
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
    },
    phpcs = {
      sourceName = "phpcs",
      command = "./vendor/bin/phpcs",
      debounce = 100,
      args = { "--report=emacs", "-s", "-" },
      offsetLine = 0,
      offsetColumn = 0,
      formatLines = 1,
      formatPattern = {
        [[^.*:(\d+):(\d+):\s+(.*)\s+-\s+(.*)(\r|\n)*$]],
        { line = 1, column = 2, security = 3, message = { "[phpcs] ", 4 } },
      },
      securities = { error = "error", warning = "warning" },
      rootPatterns = { ".git", "vendor", "composer.json" },
    },
  }

  lspconfig.diagnosticls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 500,
    },
    filetypes = vim.tbl_keys(diagnosticls_filetypes),
    init_options = {
      filetypes = diagnosticls_filetypes,
      linters = diagnosticls_linters,
    },
  }

end

return M
