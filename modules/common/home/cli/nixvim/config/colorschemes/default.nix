{...}: {
  programs = {
    nixvim = {
      colorschemes = let
        flavour = "macchiato";
      in {
        catppuccin = {
          enable = true;
          settings = {
            inherit flavour;
            background = {
              dark = flavour;
              light = flavour;
            };
            dimInactive = {
              enabled = true;
            };
            integrations = {
              alpha = true;
              gitsigns = true;
              notify = true;
              illuminate = {
                enabled = true;
                lsp = true;
              };
              treesitter = true;
              which_key = true;
              telescope = {
                enabled = true;
              };
              cmp = true;
              rainbow_delimiters = true;
              native_lsp = {
                enabled = true;
                inlay_hints = {
                  background = true;
                };
              };
              nvimtree = true;
              dap = {
                enabled = true;
                enable_ui = true;
              };
            };
          };
          styles = {};
        };
      };
    };
  };
}
