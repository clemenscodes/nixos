{ pkgs, ... }: {
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
        mainBar = {
          layer = "top";
          height = 60;
          margin = "10 10 0 10";
          modules-left = [ "hyprland/workspaces" "hyprland/window" ];
          modules-center = [ "mpd" ];
          modules-right = [
            "custom/mail"
            "custom/notification"
            "custom/idle"
            "idle_inhibitor"
            "pulseaudio"
            "pulseaudio#mic"
            "backlight"
            "network"
            "disk"
            "memory"
            "cpu"
            "battery"
            "custom/clock"
            "tray"
            "custom/powermenu"
          ];
          "hyprland/workspaces" = {
            sort-by-number = true;
            on-click = "activate";
            disable-scroll = true;
            format = "{name}: {icon}";
            format-icons = {
              "1" = " ";
              "2" = " ";
              "3" = " ";
              "6" = " ";
            };
            persistent-workspaces = {
              "eDP-1" = 3;
              "DP-1" = 3;
              "HDMI-A-1" = 3;
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
            format = "{volume}% {icon}";
            format-icons = {
              default = [ "🔈" "🔉" "🔊" ];
              headphones = [ "🎧" ];
              headset = [ "🎧" ];
            };
            format-muted = "🔇";
            max-volume = 150;
            on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };
          "pulseaudio#mic" = {
            format = "{format_source}";
            format-source = "{volume}% 🎤";
            format-source-muted = "🚫 🎤";
            scroll-step = 1;
            max-volume = 150;
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
            format-wifi = "{essid} ({signalStrength}%) 🛜";
            format-ethernet = "{ifname}: 📶";
            format-disconnected = "Disconnected 🚫";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            on-click-right = "${pkgs.kitty}/bin/kitty ${pkgs.networkmanager}/bin/nmtui";
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
      style = ''
        * {
            font-family: "Iosevka Nerd Font", sans-serif;
            font-size: 16px;
        }
        
        window#waybar {
            background: transparent;
            color: white;
        }
        
        #workspaces {
            margin-right: 8px;
            border-radius: 12px;
            transition: none;
            background-color: #22272e;
        }
        
        #workspaces button {
            transition: none;
            color: #adbac7;
            border-radius: 0;
        }
        
        #workspaces button:first-child {
            border-top-left-radius: 12px;
            border-bottom-left-radius: 12px;
        }
        
        #workspaces button:last-child {
            border-top-right-radius: 12px;
            border-bottom-right-radius: 12px;
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
            padding: 14px;
            margin: 4px;
            border-radius: 4px;
            color: #adbac7;
            background-color: #22272e;
        }

        #custom-powermenu {
            background-color: #ca0123;
            color: white;
        }
        
        @keyframes blink {
            to {
                background-color: #22272e;
                color: #adbac7;
            }
        }
        
        #battery.critical:not(.charging) {
            background-color: #f53c3c;
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
