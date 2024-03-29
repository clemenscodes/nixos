{pkgs, ...}: {
  environment = {
    systemPackages = [
      (import ./clicker {inherit pkgs;})
      (import ./dlplaylist {inherit pkgs;})
      (import ./detectidle {inherit pkgs;})
      (import ./nvidiagpuinfo {inherit pkgs;})
      (import ./lidhandle {inherit pkgs;})
      (import ./lockout {inherit pkgs;})
      (import ./signout {inherit pkgs;})
      (import ./lastchaos {inherit pkgs;})
      (import ./setupsops {inherit pkgs;})
      (import ./screenshot {inherit pkgs;})
      (import ./fullscreenshot {inherit pkgs;})
      (import ./wallpaper {inherit pkgs;})
      (import ./polkitagent {inherit pkgs;})
      (import ./sshagent {inherit pkgs;})
      (import ./logoutlaunch {inherit pkgs;})
      (import ./waybar/waybar-swaync {inherit pkgs;})
      (import ./waybar/waybar-toggle {inherit pkgs;})
      (import ./waybar/waybar-reload {inherit pkgs;})
      (import ./waybar/waybar-clock {inherit pkgs;})
      (import ./waybar/waybar-powermenu {inherit pkgs;})
      (import ./waybar/waybar-watch {inherit pkgs;})
      (import ./waybar/waybar-mail {inherit pkgs;})
    ];
  };
}
