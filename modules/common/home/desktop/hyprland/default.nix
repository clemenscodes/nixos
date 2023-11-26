{
  pkgs,
  inputs,
  machine,
  ...
}: {
  home = {
    packages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      brightnessctl
      swww
    ];
  };
  xdg = {
    configFile = {
      hypr = {
        source = ./config;
        recursive = true;
      };
      "hypr/machine.conf" = {
        source = ./config/machine/${machine}.conf;
      };
    };
  };
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        enableNvidiaPatches = machine == "desktop";
        systemd = {
          enable = false;
        };
        xwayland = {
          enable = true;
        };
        settings = {};
        extraConfig = ''
        '';
      };
    };
  };
}
