{ pkgs, ... }: {
  environment.systemPackages = [
    (import ./setupsops { inherit pkgs; })
    (import ./waybar-swaync { inherit pkgs; })
    (import ./waybar-clock { inherit pkgs; })
  ];
}
