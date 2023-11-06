{ pkgs, ...}: {
  fonts = {
    packages = with pkgs; [ 
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font Mono" ];
        sansSerif = [ "Iosevka Nerd Font" ];
        serif = [ "Iosevka Nerd Font" ];
      };
    };
    fontDir = {
      enable = true;
    };
  };
}
