{ pkgs, user, ... }: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.macchiatoBlue;
      name = "Catppuccin-Macchiato-Blue-Cursors";
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "blue";
      };
      name = "catppuccin-papirus-folders";
    };
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ]; 
        size = "standard";
        tweaks = [ "normal" ]; 
        variant = "macchiato";
      };
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
    };
    font = {
      package = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
      name = "Iosevka Nerd Font";
      size = 12;
    };
    gtk2 = {
      configLocation = "/home/${user}/.config/gtk-2.0/settings.ini";
      extraConfig = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
