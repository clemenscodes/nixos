{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.display.lockscreen;
  hyprlock = pkgs.hyprlock;
  font_family = "${osConfig.modules.fonts.defaultFont}";
  font_size = "${builtins.toString osConfig.modules.fonts.size}";
in
  with lib; {
    options = {
      modules = {
        display = {
          lockscreen = {
            hyprlock = {
              enable = mkEnableOption "Enable hyprlock" // {default = false;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.hyprlock.enable) {
      home = {
        packages = [hyprlock];
      };
      programs = {
        hyprlock = {
          inherit (cfg.hyprlock) enable;
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            inherit (osConfig.modules.themes.catppuccin) enable accent flavor;
          };
          settings = {
            general = {
              grace = 5;
              disable_loading_bar = true;
              hide_cursor = true;
            };
            background = [
              {
                path = "$XDG_DATA_HOME/images/wallpaper/badassluffy.jpg";
                blur_passes = "0";
                color = "$base";
              }
            ];
            label = [
              {
                inherit font_family font_size;
                text = "Layout: $LAYOUT";
                color = "$text";
                position = "30, -30";
                halign = "left";
                valign = "top";
              }
              {
                inherit font_family font_size;
                text = "$TIME";
                color = "$text";
                position = "-30, 0";
                halign = "right";
                valign = "top";
              }
              {
                inherit font_family;
                font_size = 90;
                text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
                color = "$text";
                position = "-30, -150";
                halign = "right";
                valign = "top";
              }
            ];
            image = {
              path = "$XDG_DATA_HOME/images/wallpaper/luffycolor.png";
              size = "100";
              border_color = "$accent";
              position = "0, 75";
              halign = "center";
              valign = "center";
            };
            input-field = {
              size = "300, 60";
              outline_thickness = "4";
              dots_size = "0.2";
              dots_spacing = "0.2";
              dots_center = true;
              outer_color = "$accent";
              inner_color = "$surface0";
              font_color = "$text";
              fade_on_empty = false;
              placeholder_text = ''<span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>'';
              hide_input = false;
              check_color = "$accent";
              fail_color = "$red";
              fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
              capslock_color = "$yellow";
              position = "0, -47";
              halign = "center";
              valign = "center";
            };
          };
        };
      };
      services = {
        hypridle = {
          inherit (cfg.hyprlock) enable;
          settings = {
            general = {
              lock_cmd = "pidof ${hyprlock}/bin/hyprlock || ${hyprlock}/bin/hyprlock";
              ignore_dbus_inhibit = false;
              before_sleep_cmd = "${pkgs.systemd}bin/loginctl lock-session";
              after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
            };
            listener = [
              {
                timeout = 120;
                on-timeout = ''${pkgs.libnotify}/bin/notify-send "Idle! dimming colors soon..."'';
              }
              {
                timeout = 150;
                on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
                on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
              }
              {
                timeout = 150;
                on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -sd rgb:kbd_backlight set 0";
                on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -rd rgb:kbd_backlight";
              }
              {
                timeout = 270;
                on-timeout = ''${pkgs.libnotify}/bin/notify-send "Locking session soon..."'';
              }
              {
                timeout = 300;
                on-timeout = "${pkgs.systemd}bin/loginctl lock-session";
              }
              {
                timeout = 330;
                on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
                on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
              }
              {
                timeout = 1800;
                on-timeout = "${pkgs.systemd}bin/systemctl suspend";
              }
            ];
          };
        };
      };
    };
  }
