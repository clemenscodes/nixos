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
          mappingPresets = ["insert"];
          sources = [
            {name = "nvim_lsp_document_symbol";}
            {name = "nvim_lsp_signature_help";}
            {name = "nvim_lsp:nil_ls";}
            {name = "cmdline";}
            {name = "luasnip";}
            {name = "path";}
            {name = "buffer";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = {
              action = "cmp.mapping.select_prev_item()";
              modes = [
                "i"
                "s"
              ];
            };
            "<Tab>" = {
              action = "cmp.mapping.select_next_item()";
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
