{...}: {
  programs = {
    nixvim = {
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          do
            require('cmp-npm').setup({
              ignore = {},
              only_semantic_versions = true,
            })
            local cmp = require('cmp')
            cmp.setup({
              ["completion"] = {
                ["autocomplete"] = {
                  require('cmp.types').cmp.TriggerEvent.TextChanged
                }
              },
              ["mapping"] = {
                ["<C-h>"] = cmp.mapping.scroll_docs(4),
                ["<C-x>"] = cmp.mapping.scroll_docs(-4),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<S-Tab>"] = cmp.mapping(
                  function(fallback)
                    local luasnip = require 'luasnip'
                    if cmp.visible() then
                      cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                      luasnip.jump(-1)
                    else
                      fallback()
                    end
                  end,
                  { "i", "s" }
                ),
                ["<Tab>"] = cmp.mapping(
                  function(fallback)
                    local luasnip = require 'luasnip'
                    if cmp.visible() then
                      cmp.select_next_item()
                    elseif luasnip.expandable() then
                      luasnip.expand();
                    elseif luasnip.expand_or_jumpable() then
                      luasnip.expand_or_jump()
                    else
                      fallback()
                    end
                  end,
                  { "i", "s" }
                )
              },
              ["preselect"] = cmp.PreselectMode.None,
              ["snippet"] = {
                ["expand"] = function(args)
                  require('luasnip').lsp_expand(args.body)
                end
              },
              ["sources"] = {
                { ["name"] = "npm", priority = 2000 },
                {
                  ["name"] = "nvim_lsp",
                  ["entryFilter"] = function(entry, ctx)
                    return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                  end
                },
                { ["name"] = "luasnip" },
                { ["name"] = "path" },
                { ["name"] = "crates" },
                { ["name"] = "lua" },
                { ["name"] = "tmux" },
              }
            })
          end
        '';
      plugins = {
        cmp = {
          enable = true;
        };
        cmp_luasnip = {
          enable = true;
        };
        cmp-nvim-lsp = {
          enable = true;
        };
        cmp-nvim-lsp-document-symbol = {
          enable = true;
        };
        cmp-nvim-lsp-signature-help = {
          enable = true;
        };
        cmp-nvim-lua = {
          enable = true;
        };
        cmp-tmux = {
          enable = true;
        };
        cmp-path = {
          enable = true;
        };
        cmp-npm = {
          enable = true;
        };
      };
    };
  };
}
