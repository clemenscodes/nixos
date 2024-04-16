{pkgs, ...}: {
  home = {
    pointerCursor = {
      name = "Catppuccin-Macchiato-Blue-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoBlue;
      size = 16;
    };
  };
}
