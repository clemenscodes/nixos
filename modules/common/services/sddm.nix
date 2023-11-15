{ locale, ... }: {
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
          settings = {};
        };
      };
    };
  };
}
