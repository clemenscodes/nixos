{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (pkgs) hyprlock hypridle;
  hyprlockExe = lib.getExe hyprlock;
  cfg = config.modules.display.lockscreen;
  font_family = "${osConfig.modules.fonts.defaultFont}";
  font_size = "25";
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${lib.getExe pkgs.playerctl} -a status | ${lib.getExe pkgs.ripgrep} Playing -q
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
  brillo = lib.getExe pkgs.brillo;
  timeout = 300;
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
        packages = [hyprlock hypridle];
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
                monitor = "";
                path = "$XDG_DATA_HOME/images/wallpaper/car.jpeg";
                blur_passes = "0";
                color = "$base";
                ignore_empty_input = true;
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
                inherit font_family;
                text = "$TIME";
                font_size = "90";
                color = "$text";
                position = "-30, 0";
                halign = "right";
                valign = "top";
              }
              {
                inherit font_family font_size;
                text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
                color = "$text";
                position = "-30, -150";
                halign = "right";
                valign = "top";
              }
            ];
            input-field = {
              monitor = "";
              inherit font_family;
              size = "250, 60";
              outline_thickness = "2";
              dots_size = "0.2";
              dots_spacing = "0.35";
              dots_center = true;
              outer_color = "$accent";
              inner_color = "$surface0";
              font_color = "$text";
              fade_on_empty = false;
              check_color = "$accent";
              rounding = "-1";
              placeholder_text = ''<span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>'';
              hide_input = false;
              fail_color = "$red";
              fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
              capslock_color = "$yellow";
              position = "0, -200";
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
              lock_cmd = "pidof ${hyprlockExe} || ${hyprlockExe}";
              before_sleep_cmd = "${pkgs.systemd}bin/loginctl lock-session";
            };
            listener = [
              {
                timeout = (timeout / 2) - 30;
                on-timeout = ''${pkgs.libnotify}/bin/notify-send "Idle! dimming colors soon..."'';
              }
              {
                timeout = (timeout / 2) - 10;
                on-timeout = "${brillo} -O; ${brillo} -u 1000000 -S 10";
                on-resume = "${brillo} -I -u 500000";
              }
              {
                timeout = timeout - 30;
                on-timeout = ''${pkgs.libnotify}/bin/notify-send "Locking session soon..."'';
              }
              {
                inherit timeout;
                on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
              }
              {
                timeout = timeout + 30;
                on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
                on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
              }
              {
                timeout = timeout * 2;
                on-timeout = suspendScript.outPath;
              }
            ];
          };
        };
      };
    };
  }
