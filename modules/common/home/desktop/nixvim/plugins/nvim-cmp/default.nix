{...}: {
  programs = {
    nixvim = {
      options = {
        completeopt = "menu,menuone,noselect";
      };
      plugins = {
        nvim-cmp = {
          enable = true;
          extraOptions = {
            sources = [
              {
                name = "nvim_lsp";
                entryFilter.__raw =
                  /*
                  lua
                  */
                  ''
                    function(entry, ctx)
                      return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                    end
                  '';
              }
              {name = "luasnip";}
              {name = "path";}
              {name = "crates";}
              {name = "lua";}
              {name = "tmux";}
              {name = "npm";}
            ];
          };
          preselect = "None";
          # sources = [
          #   {
          #     name = "nvim_lsp";
          #     entryFilter = ''
          #       function(entry, ctx)
          #         return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
          #       end
          #     '';
          #   }
          #   {name = "luasnip";}
          #   {name = "path";}
          # ];
          mapping = {
            "<CR>" =
              /*
              lua
              */
              "cmp.mapping.confirm({ select = true })";
            "<Tab>" = {
              action =
                /*
                lua
                */
                ''
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
                  end
                '';
              modes = ["i" "s"];
            };
            "<S-Tab>" = {
              action =
                /*
                lua
                */
                ''
                  function(fallback)
                    local luasnip = require 'luasnip'
                    if cmp.visible() then
                      cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                       luasnip.jump(-1)
                    else
                      fallback()
                    end
                  end
                '';
              modes = [
                "i"
                "s"
              ];
            };
          };
          snippet = {
            expand = "luasnip";
          };
          completion = {
            autocomplete = ["TextChanged"];
          };
          extraOptions = {};
        };
      };
    };
  };
}
