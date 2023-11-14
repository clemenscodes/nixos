{ ... }: {
  services = {
    xserver = {
      enable = true;
      layout = "de";
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
