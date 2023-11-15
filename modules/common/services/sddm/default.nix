{ pkgs, locale, ... }: {
  environment = {
    systemPackages = with pkgs; [
     libsForQt5.qt5.qtquickcontrols2   
     libsForQt5.qt5.qtgraphicaleffects
    ];
  };
  services = {
    xserver = {
      enable = true;
      layout = locale;
      displayManager = {
        defaultSession = "hyprland";
        sddm = {
          enable = true;
          enableHidpi = true;
          wayland = {
            enable = true;
          };
          theme = "${import ./themes/catppuccin-macchiato.nix { inherit pkgs; }}";
        };
      };
    };
  };
}
