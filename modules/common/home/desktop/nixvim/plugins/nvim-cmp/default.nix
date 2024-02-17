{...}: {
  programs = {
    nixvim = {
      plugins = {
        nvim-cmp = {
          enable = true;
          preselect = "None";
          mappingPresets = [ "insert" ];
          sources = [
            { name = "nvim_lsp_document_symbol"; }
            { name = "cmdline"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          snippet = {
            expand = "luasnip";
          };
          completion = {
            autocomplete = ["TextChanged"];
            completeopt = "menu,menuone,noselect";
          };
          extraOptions = {};
        };
      };
    };
  };
}
