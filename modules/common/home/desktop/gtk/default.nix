{ pkgs, user, ... }: 
  let
    iconTheme = pkgs.catppuccin-papirus-folders.override {
      flavor = "macchiato";
      accent = "blue";
    };
  in 
{
  home = {
    packages = with pkgs; [
      libsForQt5.breeze-icons
      hicolor-icon-theme
    ];
    file = {
      ".icons/Papirus-Dark" = {
        source = "${iconTheme}/share/icons/Papirus-Dark";
       }; 
      ".local/share/.icons/Papirus-Dark" = {
        source = "${iconTheme}/share/icons/Papirus-Dark";
      };
    };
  };
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.macchiatoBlue;
      name = "Catppuccin-Macchiato-Blue-Cursors";
    };
    iconTheme = {
      package = iconTheme;
      name = "Papirus-Dark";
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
