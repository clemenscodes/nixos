{
  pkgs,
  user,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Iosevka"];})
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Iosevka Nerd Font Mono"];
        sansSerif = ["Iosevka Nerd Font"];
        serif = ["Iosevka Nerd Font"];
      };
    };
  };
}
