{pkgs,...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [ripgrep fd];
      plugins = {
        telescope = {
          enable = true;
          highlightTheme = "catppuccin";
          keymaps = {};
          keymapsSilent = true;
          extraOptions = {};
        };
      };
    };
  };
}
