{ pkgs, user, terminal, ... }: {
  home = {
    packages = with pkgs; [
      libappindicator-gtk3
      libdbusmenu-gtk3
    ];
  };
  programs = {
    waybar = {
      enable = true;
      systemd = {
        enable = false;
      };
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
            "custom/mail"
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
            format = " -> {id}";
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
          "custom/mail" = {
            format = "{}";
            interval = 5;
            exec = "waybar-mail";
            on-click = "${pkgs.kitty}/bin/kitty neomutt";
          };
          disk = {
            interval = 30;
            format = "{percentage_used}% 💾";
            tooltip-format = "{used}/{total} 💾";
            on-click = "${pkgs.kitty}/bin/kitty ${pkgs.ncdu}/bin/ncdu";
            path = "/";
          };
          memory = {
            format = "{percentage}% 🧠";
            format-alt = "󰾅  {used}GB";
            tooltip-format = "{used:0.1f}G/{total:0.1f}GB  ";
            on-click = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop";
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
            on-click = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop";
          };
          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}  ";
            format-critical = "{temperatureC}°C 🔥  ";
            on-click = "${pkgs.kitty}/bin/kitty ${pkgs.btop}/bin/btop";
            format-icons = ["🌡️"];
          };
          "custom/nvidiagpuinfo" = {
            format = "{} 🌡️";
            exec = "nvidiagpuinfo";
            return-type = "json";
            on-click = "nvidia-settings";
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
            format = "";
            on-click = "sleep 0.1 && logoutlaunch";
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
          ];
          modules-center = [ 
            "privacy"
          ];
          modules-right = [ 
            "custom/notification"
            "idle_inhibitor"
            "tray"
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
          "wlr/taskbar" = {
            format = "{icon}";
            on-click = "activate";
            on-click-middle = "fullscreen";
            on-click-right = "close";
            icon-theme = "Papirus-Dark";
            icon-size = 22;
            markup = true;
            tooltip = false;
            spacing = 0;
          };
          "custom/notification" = {
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'></span>";
              none = "<span></span>";
              dnd-notification = "<span foreground='red'></span>";
              dnd-none = "<span></span>";
              dnd-inhibited-notification = "<span foreground='red'></span>";
              dnd-inhibited-none = "<span></span>";
              inhibited-notification = "<span foreground='red'></span>";
              inhibited-none = "<span></span>";
            };
            return-type = "json"; 
            tooltip = false;
            exec-if = "which ${pkgs.swaynotificationcenter}/bin/swaync-client";
            exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
            on-click = "waybar-swaync";
            escape = true;
          };
          privacy = {
            icon-spacing = 4;
	    icon-size = 18;
	    transition-duration = 250;
	    modules = [
	      {
	      	type = "screenshare";
	      	tooltip = true;
	      	tooltip-icon-size = 24;
	      }
	      {
	      	type = "audio-out";
	      	tooltip = true;
	      	tooltip-icon-size = 24;
	      }
	      {
	      	type = "audio-in";
	      	tooltip = true;
	      	tooltip-icon-size = 24;
	      }
	    ];
          };
          "custom/idle" = {
            format = "{icon}";
            exec = "${import ../sway-audio-idle-inhibit {inherit pkgs; }}/bin/sway-audio-idle-inhibit --dry-print-both-waybar";
            exec-if = "which ${import ../sway-audio-idle-inhibit {inherit pkgs; }}/bin/sway-audio-idle-inhibit";
            format-alt = "";
            return-type = "json";
            on-click = "${import ../sway-audio-idle-inhibit {inherit pkgs; }}/bin/sway-audio-idle-inhibit --dry-print-both-waybar";
            format-icons = {
              output = "🎧";
              input = "🎙️";
              output-input = "🎧🎙️";
              none = "🎯";
            };
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = ""; 
              deactivated = "";
            };
          };
          tray = {
            icon-size = "24";
            spacing = 10;
            interval = 1;
            show-passive-items = true;
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
            on-click = "${pkgs.kitty}/bin/kitty ${pkgs.calcurse}/bin/calcurse";
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
          font-family: "Iosevka Nerd Font Mono";
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
          padding: 12px;
          ${defaultBackground}
          ${defaultColor}
        }

        #image {
          margin: 0px 6px 12px ${defaultMargin};
        }
        
        #workspaces {
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
          ${defaultBackground}
          margin: 0px 6px 12px 6px;
          border-radius: 20px;
        }

        #taskbar button {
          ${defaultBackground}
          ${fadeIn}
          padding: 12px;
          border-radius: 20px;
        }

        #taskbar button.active {
          color: #909dab;
          ${fadeOut}
          background-color: #2d333b;
        }

        #taskbar button.hover {
          color: #909dab;
          ${fadeOut}
          background-color: #2d333b;
        }

        #taskbar.empty {
          ${hide}
          padding: 0px;
        }

        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #pulseaudio,
        #pulseaudio.mic,
        #idle_inhibitor,
        #tray,
        #privacy,
        #privacy-item,
        #privacy-item.screenshare,
        #privacy-item.audio-in,
        #privacy-item.audio-out,
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
        #custom-mail,
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
        #custom-idle,
        #privacy,
        #privacy-item,
        #privacy-item.screenshare,
        #privacy-item.audio-in,
        #privacy-item.audio-out,
        #custom-notification,
        #idle_inhibitor,
        #backlight,
        #pulseaudio,
        #pulseaudio.mic,
        #custom-clock {
          margin: 0px 4px ${defaultMargin} 4px;
        }

        
        #custom-notification,
        #custom-powermenu,
        #idle_inhibitor {
          padding: 0px 12px;
          font-size: 28px;
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

        #tray menu {
          ${padding}
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
