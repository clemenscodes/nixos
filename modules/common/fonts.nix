{ pkgs, ...}: {
  fonts = {
    packages = with pkgs; [ iosevka ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka" ];
        sansSerif = [ "Iosevka" ];
        serif = [ "Iosevka" ];
      };
    };
    fontDir = {
      enable = true;
    };
  };
}
