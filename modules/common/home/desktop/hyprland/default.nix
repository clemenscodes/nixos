{ pkgs, inputs, ... }: {
  home = {
    packages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
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
    };
  };
}
