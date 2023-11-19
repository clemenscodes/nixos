{ pkgs, user, ... }: {
  home = {
    packages = with pkgs; [
      libappindicator-gtk3
      libdbusmenu-gtk3
    ];
  };
  programs = {
    waybar = {
      enable = true;
      package = (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }));
      settings =
        let
          height = 48;
          max-volume = 150;
        in
      [
        {
          inherit height;
          layer = "top";
          position = "top";
          name = "topBar";
          modules-left = [ 
            "hyprland/workspaces"
          ];
          modules-center = [
            "mpd"
          ];
          modules-right = [
            "disk"
            "memory"
            "temperature"
            "custom/nvidiagpuinfo"
            "cpu"
            "battery"
            "custom/powermenu"
          ];
          "hyprland/workspaces" = {
            sort-by-number = true;
            on-click = "activate";
            on-click-right = "close";
            disable-scroll = true;
            all-outputs = true;
            format = "  -> {id}";
            persistent-workspaces = {
              "*" = 5;
            };
          };
          mpd = {
            format = "⸨{songPosition}|{queueLength}⸩ {artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) 🎵";
            format-disconnected = "Disconnected 🎵";
            format-stopped = "";
            unknown-tag = "N/A";
            interval = 2;
            server = "/run/user/1000/mpd/socket";
            consume-icons = {
              on = "✂️";
            };
            random-icons = {
              off = "<span color=\"#f53c3c\">🔀</span> ";
              on = "🔀";
            };
            repeat-icons = {
              on = "🔁";
            };
            single-icons = {
              on = "🔂";
            };
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
          };
          disk = {
            interval = 30;
            format = "{percentage_used}% 💾";
            tooltip-format = "{used}/{total} 💾";
            path = "/";
          };
          memory = {
            format = "{percentage}% 🧠";
            format-alt = "󰾅  {used}GB";
            tooltip-format = "{used:0.1f}G/{total:0.1f}GB  ";
            interval = 30;
            tooltip = true;
          };
          cpu = {
            interval = 1;
            format = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7} {usage}%  ";
            format-icons = [
              "<span color='#69ff94'>▁</span>" # green
              "<span color='#2aa9ff'>▂</span>" # blue
              "<span color='#f8f8f2'>▃</span>" # white
              "<span color='#f8f8f2'>▄</span>" # white
              "<span color='#ffffa5'>▅</span>" # yellow
              "<span color='#ffffa5'>▆</span>" # yellow
              "<span color='#ff9977'>▇</span>" # orange
              "<span color='#dd532e'>█</span>" # red
            ];
          };
          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}  ";
            format-critical = "{temperatureC}°C 🔥  ";
            format-icons = ["🌡️"];
          };
          "custom/nvidiagpuinfo" = {
            format = "{} 🌡️";
            exec = "nvidiagpuinfo";
            return-type = "json";
            interval = 5;
            tooltip = true;
          };
          battery = {
            states = {
              good = 95;
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ⚡";
            format-plugged = "{capacity}% 🔌";
            format-alt = "{time} {icon}";
            format-icons = [" " " " " " " " " "];
          };
          "custom/powermenu" = {
            format = " ";
            on-click = "wlogout";
            exec = "waybar-powermenu";
            tooltip = false;
          };
        }
        {
          inherit height;
          name = "bottomBar";
          layer = "top";
          position = "bottom";
          modules-left = [ 
            "image#logo" 
            "wlr/taskbar"
            "tray"
            "custom/mail"
          ];
          modules-center = [ 
            "custom/idle"
          ];
          modules-right = [ 
            "custom/notification"
            "idle_inhibitor"
            "network"
            "backlight"
            "pulseaudio"
            "pulseaudio#mic"
            "custom/clock"
          ];
          "image#logo" = {
            path = "/home/${user}/.local/share/images/svg/nix-snowflake.svg";
            size = height;
            on-click = "sleep 0.3; ${pkgs.rofi-wayland}/bin/rofi -show drun";
          };
          tray = {
            icon-size = "24";
            spacing = 10;
            show-passive-items = true;
          };
          "custom/mail" = {
            format = "{}";
            interval = 3;
            exec = "waybar-mail";
            on-click = "${pkgs.kitty}/bin/kitty neomutt";
          };
          "wlr/taskbar" = {
            format = "{icon}";
            tooltip-format = "{title} {app_id}";
            on-click = "activate";
            on-click-middle = "fullscreen";
            on-click-right = "close";
            icon-theme = "Papirus-Dark";
            icon-size = 22;
            all-outputs = true;
            spacing = 0;
          };
          "custom/notification" = {
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'> </span>";
              none = "<span> </span>";
              dnd-notification = "<span foreground='red'> </span>";
              dnd-none = "<span> </span>";
              dnd-inhibited-notification = "<span foreground='red'> </span>";
              dnd-inhibited-none = "<span> </span>";
              inhibited-notification = "<span foreground='red'> </span>";
              inhibited-none = "<span> </span>";
            };
            return-type = "json"; 
            exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
            on-click = "waybar-swaync";
            escape = true;
          };
          "custom/idle" = {
            format = "{icon}";
            exec = "${import ../sway-audio-idle-inhibit {inherit pkgs; }}/bin/sway-audio-idle-inhibit --dry-print-both-waybar";
            exec-if = "which ${import ../sway-audio-idle-inhibit {inherit pkgs; }}/bin/sway-audio-idle-inhibit";
            format-alt = "";
            return-type = "json";
            format-icons = {
              output = " ";
              input = " ";
              output-input = "   ";
              none = "";
            };
          };
          idle_inhibitor = {
            format = "{icon} ";
            format-icons = {
              activated = ""; 
              deactivated = "";
            };
          };
          network = {
            format-wifi = "🛜";
            format-ethernet = "📶";
            format-disconnected = "📡🚫";
            tooltip-format = "{gwaddr}";
            format-linked = "(No IP)";
            format-alt = "({signalStrength}%)";
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = ["🌑" "🌘" "🌗" "🌖" "🌕"];
            on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%+";
            on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%-";
          };
          pulseaudio = {
            inherit max-volume;
            format = "{volume}% {icon}";
            format-icons = {
              default = [ "🔈" "🔉" "🔊" ];
              headphones = [ "🎧" ];
              headset = [ "🎧" ];
            };
            format-muted = "🔇";
            on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };
          "pulseaudio#mic" = {
            inherit max-volume;
            format = "{format_source}";
            format-source = "{volume}% 🎤";
            format-source-muted = "🚫 🎤";
            scroll-step = 1;
            on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-";
            on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SOURCE@ 1%+";
            on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };
          "custom/clock" = {
            format = "{}";
            interval = 1;
            exec = "waybar-clock";
          };
        }
      ];
      style =
        let 
          padding = "padding: 12px;";
          borderRadius = "12px";
          defaultBackground = "background-color: #22272e;";
          animation = "animation: gradient_f 20s ease-in infinite;";
          hide = "background: transparent;";
          fadeIn = ''
            ${animation}
            transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
          '';
          fadeOut = ''
            ${animation}
            transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
          '';
          defaultColor = "color: #adbac7;";
          defaultMargin = "12px";
        in
      ''
        * {
          padding: 0px;
          margin: 0px;
          min-height: 0px;
          min-width: 0px;
          font-family: "Iosevka Nerd Font", sans-serif;
          font-size: 16px;
        }
        
        window#waybar.topBar,
        window#waybar.bottomBar
        {
          ${hide}
          color: white;
        }
        
        tooltip {
          border-radius: ${borderRadius};
          border-width: 0px;
          ${defaultBackground}
          ${defaultColor}
        }

        #image {
          margin: 0px 6px 12px ${defaultMargin};
        }
        
        #workspaces,
        #taskbar
        {
          margin: ${defaultMargin} 0px 0px ${defaultMargin};
          border-radius: 12px;
          ${defaultBackground}
          ${defaultColor}
        }
        
        #workspaces button {
          ${padding}
          ${fadeOut}
          border-radius: 0;
        }

        #workspaces button:first-child {
          border-top-left-radius: ${borderRadius};
          border-bottom-left-radius: ${borderRadius};
        }
        
        #workspaces button:last-child {
          border-top-right-radius: ${borderRadius};
          border-bottom-right-radius: ${borderRadius};
        }
        
        #workspaces button:hover {
          color: #909dab;
          background-color: white;
          ${fadeIn}
        }
        
        #workspaces button.active {
          color: #282828;
          background-color: white;
          ${fadeIn}
        }
        
        #workspaces button.urgent {
          background-color: #eb4d4b;
        }

        #taskbar {
          padding: 6px;
          margin: ${defaultMargin};
          margin-top: 0px;
        }

        #taskbar button {
          padding: 6px;
          ${fadeOut}
          border-radius: 20px;;
        }

        #taskbar button.active {
          color: #909dab;
          ${fadeIn}
        }

        #taskbar button.hover {
          color: #909dab;
          ${fadeIn}
        }

        #taskbar.empty {
          ${hide}
        }

        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #pulseaudio.mic,
        #idle_inhibitor,
        #tray,
        #custom-clock,
        #custom-notification,
        #custom-powermenu,
        #custom-mail,
        #custom-idle,
        #custom-nvidiagpuinfo,
        #mpd {
          ${padding}
          ${defaultColor}
          ${defaultBackground}
          border-radius: 4px;
        }

        #mpd,
        #disk,
        #memory,
        #cpu,
        #temperature,
        #custom-nvidiagpuinfo,
        #battery,
        #custom-powermenu {
          margin: ${defaultMargin} 4px 0px 4px;
        }

        #tray,
        #custom-mail,
        #custom-idle,
        #custom-notification,
        #idle_inhibitor,
        #network,
        #backlight,
        #pulseaudio,
        #pulseaudio.mic,
        #custom-clock {
          margin: 0px 4px ${defaultMargin} 4px;
        }

        #custom-clock {
          margin-right: ${defaultMargin};
        }

        #custom-powermenu {
          background-color: #f53c3c;
          color: white;
          margin-right: ${defaultMargin};
        }
        
        @keyframes blink {
          to {
            background-color: #f53c3c;
          }
        }
        
        #battery.critical:not(.charging) {
          ${defaultBackground}
          ${defaultColor}
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }
        
        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
        }
      '';
    };
  };
}
