{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      swayidle
    ];
  };
  services = {
    swayidle = {
      enable = false;
      systemdTarget = "graphical-session.target";
      timeouts = [
        {
          timeout = 10;
          command = "${pkgs.libnotify}/bin/notify-send 'Idle! Locking soon...";
        }
        {
          timeout = 20;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 30;
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        }
      ];
      events = [
        {
          event = "after-resume";
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock}/bin/swaylock";
        }
      ];
    };
  };
}
