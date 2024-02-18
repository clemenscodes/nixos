{...}: {
  programs = {
    nixvim = {
      options = {
        completeopt = "menu,menuone,noselect";
      };
      plugins = {
        nvim-cmp = {
          enable = true;
          preselect = "None";
          sources = [
            {name = "nvim_lsp";}
            {name = "cmdline";}
            {name = "luasnip";}
            {name = "path";}
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = {
              action = /* lua */ ''
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
              modes = [ "i" "s" ];
            };
            "<S-Tab>" = {
              action = "cmp.mapping.select_prev_item()";
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
