{ pkgs, ... }: {
  home = {
    pointerCursor = {
      gtk = {
        enable = true;
      };
      name = "Catppuccin-Macchiato-Blue-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoBlue;
      size = 16;
    };
  };
}
