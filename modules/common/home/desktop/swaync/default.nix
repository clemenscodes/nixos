{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      swaynotificationcenter
      libnotify
    ];
  };
  xdg = {
    configFile = {
      swaync = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
