{...}: {
  programs = {
    nixvim = {
      colorschemes = {
        catppuccin = {
          enable = true;
          flavour = "macchiato";
          integrations = {
            dashboard = true;
            gitsigns = true;
          };
          styles = {};
        };
      };
    };
  };
}
