{ pkgs, ... }: {
  environment = {
    systemPackages = [
      (import ./setupsops { inherit pkgs; })
      (import ./waybar-swaync { inherit pkgs; })
      (import ./waybar-clock { inherit pkgs; })
      (import ./waybar-powermenu { inherit pkgs; })
      (import ./waybar-mail { inherit pkgs; })
    ];
  };
}
