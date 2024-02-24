{...}: {
  programs = {
    nixvim = {
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true

          require'lspconfig'.cssls.setup {
            capabilities = capabilities,
            settings = {
              css = {
                validate = false,
                lint = {
                  unknownAtRules = "ignore"
                }
              },
              scss = {
                validate = false,
                lint = {
                  unknownAtRules = "ignore"
                }
              },
              less = {
                validate = false,
                lint = {
                  unknownAtRules = "ignore"
                }
              }
            }
          }
        '';
      plugins = {
        lsp = {
          servers = {
            cssls = {
              enable = true;
            };
          };
        };
      };
    };
  };
}
