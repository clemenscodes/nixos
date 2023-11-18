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
      settings = {
        mainBar = 
          let
            height = 48;
            max-volume = 150;
          in
        {
          inherit height;
          layer = "top";
          modules-left = [ "image#logo" "hyprland/workspaces" "hyprland/window" ];
          modules-center = [ "mpd" ];
          modules-right = [
            "custom/mail"
            "tray"
            "custom/notification"
            "custom/idle"
            "idle_inhibitor"
            "network"
            "pulseaudio"
            "pulseaudio#mic"
            "backlight"
            "disk"
            "memory"
            "cpu"
            "battery"
            "custom/clock"
            "custom/powermenu"
          ];
          "hyprland/workspaces" = {
            sort-by-number = true;
            on-click = "activate";
            disable-scroll = true;
            format = "{name}: {icon}";
            format-icons = {
              "1" = " ";
              "2" = " ";
              "3" = " ";
            };
          };
          "hyprland/window" = {
            format = "👉 {title}";
            max-length = 200;
            separate-outputs = true;
          };
          tray = {
            icon-size = "24";
            spacing = 10;
            show-passive-items = true;
          };
          idle_inhibitor = {
            format = "{icon} ";
            format-icons = {
              activated = ""; 
              deactivated = "";
            };
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
          disk = {
            interval = 30;
            format = "{used}/{total} 💾";
            path = "/";
          };
          network = {
            format-wifi = "🛜";
            format-ethernet = "📶";
            format-disconnected = "{ifname} 🚫";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-alt = "{essid} ({signalStrength}%)";
          };
          mpd = {
            format = "{artist} - {title} ⸨{songPosition}|{queueLength}⸩ 🎵";
            format-disconnected = "Disconnected 🎵";
            format-stopped = ""; # Dont clutter space when inactive
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
            state-icons = {
              paused = "⏸️ ";
              playing = "▶️";
            };
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
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
          memory = {
            interval = 30;
            format = "{used:0.1f}G/{total:0.1f}G 🧠";
          };
          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["🌡️"];
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = ["🌑" "🌘" "🌗" "🌖" "🌕"];
            on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%+";
            on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%-";
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
          "image#logo" = {
            path = "/home/${user}/.local/share/images/nix-snowflake.svg";
            size = height;
            on-click = "sleep 0.3; ${pkgs.rofi-wayland}/bin/rofi -show drun";
          };
          "custom/clock" = {
            format = "{}";
            interval = 1;
            exec = "waybar-clock";
          };
          "custom/mail" = {
            format = "{}";
            interval = 3;
            exec = "waybar-mail";
            on-click = "${pkgs.kitty}/bin/kitty neomutt";
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
          "custom/powermenu" = {
            format = " ";
            on-click = "wlogout";
            exec = "waybar-powermenu";
            tooltip = false;
          };
           "custom/idle" = {
             format = "{icon}";
             exec = "${import ../sway-audio-idle-inhibit {inherit pkgs; }}/bin/sway-audio-idle-inhibit --dry-print-both-waybar";
             exec-if = "which ${import ../sway-audio-idle-inhibit {inherit pkgs; }}/bin/sway-audio-idle-inhibit";
             return-type = "json";
             format-icons = {
               output = " ";
               input = " ";
               output-input = "   ";
               none = "";
             };
          };
        };
      };
      style =
        let 
          padding = "padding: 12px;";
          borderRadius = "12px";
          defaultBackground = "background-color: #22272e;";
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
        
        window#waybar {
          background: transparent;
          color: white;
        }

        #image {
          margin: 12px 6px 0px 12px;
        }
        
        #workspaces {
          margin: 12px 0px 0px 6px;
          border-radius: 12px;
          ${defaultBackground}
        }
        
        #workspaces button {
          ${padding}
          transition: none;
          color: #adbac7;
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
        }
        
        #workspaces button.active {
          color: #282828;
          background-color: white;
        }
        
        #workspaces button.urgent {
          background-color: #eb4d4b;
        }

        #window {
          ${padding}
          margin: 12px 6px 0px 0px;
          color: #adbac7;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #idle_inhibitor,
        #tray,
        #pulseaudio,
        #pulseaudio.mic,
        #custom-media,
        #custom-clock,
        #custom-notification,
        #custom-powermenu,
        #custom-mail,
        #custom-idle,
        #mpd {
          ${padding}
          margin: 12px 4px 0px 4px;
          border-radius: 4px;
          color: #adbac7;
          ${defaultBackground}
        }

        #mpd {
          margin-left: 6px;
        }

        #custom-powermenu {
          background-color: #ca0123;
          color: white;
          margin-right: 12px;
        }
        
        @keyframes blink {
          to {
            background-color: #f53c3c;
          }
        }
        
        #battery.critical:not(.charging) {
          ${defaultBackground}
          color: #adbac7;
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
