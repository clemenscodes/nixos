{ pkgs, ... }: {
  environment = {
    systemPackages = [
      (import ./idle { inherit pkgs; })
      (import ./setupsops { inherit pkgs; })
      (import ./screenshot { inherit pkgs; })
      (import ./wallpaper { inherit pkgs; })
      (import ./waybar-swaync { inherit pkgs; })
      (import ./waybar-clock { inherit pkgs; })
      (import ./waybar-powermenu { inherit pkgs; })
      (import ./waybar-mail { inherit pkgs; })
    ];
  };
}
