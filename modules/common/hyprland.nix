{ pkgs, inputs, ... }: {
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      enableNvidiaPatches = true;
      xwayland = {
        enable = true;
      };
    };
  };
}
