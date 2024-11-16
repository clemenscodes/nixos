{...}: {
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  displayCfg = config.modules.display;
  cfg = displayCfg.compositor;
  machine = osConfig.modules.machine.kind;
  useHyprpicker = cfg.hyprland.hyprpicker.enable;
  useKitty = config.modules.terminal.kitty.enable;
  useObs = config.modules.media.video.obs.enable;
  useMusic = config.modules.media.music.enable;
  useNcmpcpp = config.modules.media.music.ncmpcpp.enable;
  useScreenshots = displayCfg.screenshots.enable;
  useRofi = displayCfg.launcher.rofi.enable;
  useSwaync = displayCfg.notifications.swaync.enable;
  useWaybar = displayCfg.bar.waybar.enable;
  useBtop = config.modules.monitoring.btop.enable;
  useCalcurse = config.modules.organization.calcurse.enable;
  useEmail = config.modules.organization.email.enable;
  useLf = config.modules.explorer.lf.enable;
  useYazi = config.modules.explorer.yazi.enable;
  useNvim = config.modules.editor.nixvim.enable;
  useFirefox = config.modules.browser.firefox.enable;
  useDavinci = config.modules.media.editing.davinci.enable;
  useBlueman = config.modules.networking.bluetooth.blueman.enable;
  useNm = config.modules.networking.nm.enable;
  useSwayidle = displayCfg.lockscreen.swayidle.enable;
  useSwayAudioIdle = displayCfg.lockscreen.sway-audio-idle-inhibit.enable;
  useSsh = config.modules.security.ssh.enable;
  useTorrent = osConfig.modules.networking.torrent.enable;
  useUdiskie = osConfig.modules.io.udisks.enable;
  isLaptop = machine == "laptop";
in
  with lib; {
    imports = [
      ./hyprshade
      ./hyprpicker
      ./xwayland
    ];
    options = {
      modules = {
        display = {
          compositor = {
            hyprland = {
              enable = mkEnableOption "Enable anime titties" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.hyprland.enable) {
      home = {
        packages = with pkgs; [
          xdg-desktop-portal-hyprland
          brightnessctl
          swww
          wl-clipboard
          cliphist
          (import ./wallpaper {inherit pkgs;})
          (mkIf isLaptop (import ./lidhandle {inherit pkgs;}))
        ];
      };
      wayland = {
        windowManager = {
          hyprland = {
            enable = cfg.hyprland.enable;
            catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
              inherit (osConfig.modules.themes.catppuccin) enable flavor;
            };
            systemd = {
              enable = false;
            };
            settings = {
              input = {
                kb_layout = osConfig.modules.locale.defaultLocale;
                follow_mouse = 0;
                repeat_rate = 50;
                repeat_delay = 300;
                touchpad = {
                  natural_scroll = "no";
                };
                sensitivity = 0;
              };

              general = {
                gaps_in = 6;
                gaps_out = 12;
                border_size = 2;
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";
                layout = "master";
              };

              decoration = {
                rounding = 4;
                blur = {
                  enabled = true;
                  size = 1;
                  noise = 0.01;
                  brightness = 1.423;
                  contrast = 1.309;
                  passes = 2;
                  special = false;
                };
              };

              gestures = {
                workspace_swipe = "on";
                workspace_swipe_fingers = 3;
              };

              misc = {
                enable_swallow = true;
                disable_hyprland_logo = true;
                disable_splash_rendering = true;
                vrr = 1;
              };

              binds = {
                allow_workspace_cycles = true;
              };

              "$mod" = "SUPER";

              bind = [
                "$mod, F, fullscreen"
                "$mod, Q, killactive"
                "$mod, C, exec, hyprctl reload"
                "$mod, W, exec, uwsm app -- $BROWSER"
                "$mod SHIFT, C, exec, ${pkgs.uwsm}/bin/uwsm stop"
                "$mod SHIFT, F, togglefloating,"
                "$mod, SPACE, layoutmsg, swapwithmaster"

                "$mod, 1, workspace, 1"
                "$mod, 2, workspace, 2"
                "$mod, 3, workspace, 3"
                "$mod, 4, workspace, 4"
                "$mod, 5, workspace, 5"
                "$mod, 6, workspace, 6"
                "$mod, 7, workspace, 7"
                "$mod, 8, workspace, 8"
                "$mod, 9, workspace, 9"
                "$mod, 0, workspace, 10"

                "$mod SHIFT, 1, movetoworkspace, 1"
                "$mod SHIFT, 2, movetoworkspace, 2"
                "$mod SHIFT, 3, movetoworkspace, 3"
                "$mod SHIFT, 4, movetoworkspace, 4"
                "$mod SHIFT, 5, movetoworkspace, 5"
                "$mod SHIFT, 6, movetoworkspace, 6"
                "$mod SHIFT, 7, movetoworkspace, 7"
                "$mod SHIFT, 8, movetoworkspace, 8"
                "$mod SHIFT, 9, movetoworkspace, 9"
                "$mod SHIFT, 0, movetoworkspace, 10"
                "$mod SHIFT, LEFT, movetoworkspace, -1"
                "$mod SHIFT, RIGHT, movetoworkspace, +1"
                "$mod SHIFT_R, 1, movetoworkspace, 1"
                "$mod SHIFT_R, 2, movetoworkspace, 2"
                "$mod SHIFT_R, 3, movetoworkspace, 3"
                "$mod SHIFT_R, 4, movetoworkspace, 4"
                "$mod SHIFT_R, 5, movetoworkspace, 5"
                "$mod SHIFT_R, 6, movetoworkspace, 6"
                "$mod SHIFT_R, 7, movetoworkspace, 7"
                "$mod SHIFT_R, 8, movetoworkspace, 8"
                "$mod SHIFT_R, 9, movetoworkspace, 9"
                "$mod SHIFT_R, 0, movetoworkspace, 10"
                "$mod SHIFT_R, LEFT, movetoworkspace, -1"
                "$mod SHIFT_R, RIGHT, movetoworkspace, +1"

                # Switch workspaces with mod + [0-9]
                # Move active window to a workspace with mod + SHIFT + [0-9]
                # Scroll through existing workspaces with mod + scroll
                "$mod, mouse_down, workspace, e+1"
                "$mod, mouse_up, workspace, e-1"

                (mkIf useHyprpicker "$mod, U, exec, uwsm app -- hyprpicker")
                (mkIf useKitty "$mod, RETURN, exec, uwsm app -- kitty")
                (mkIf (useKitty && useNvim) "$mod, V, exec, uwsm app -- kitty nvim")
                (mkIf (useKitty && useLf) "$mod, R, exec, uwsm app -- kitty lf")
                (mkIf (useKitty && useYazi) "$mod, R, exec, uwsm app -- kitty yazi")
                (mkIf (useKitty && useEmail) "$mod, E, exec, uwsm app -- kitty neomutt")
                (mkIf (useKitty && useBtop) "$mod SHIFT, R, exec, uwsm app -- kitty btop")
                (mkIf (useKitty && useNcmpcpp) "$mod, M, exec, uwsm app -- kitty ncmpcpp")
                (mkIf (useKitty && useCalcurse) "$mod SHIFT, K, exec, uwsm app -- kitty calcurse")
                (mkIf useWaybar "$mod, B, exec, uwsm app -- waybar-toggle")
                (mkIf useWaybar "$mod SHIFT, B, exec, uwsm app -- waybar-reload")
                (mkIf useSwaync "$mod, N, exec, uwsm app -- swaync-client -t -sw")
                (mkIf useRofi "$mod SHIFT, V, exec, uwsm app -- cliphist list | rofi -dmenu | cliphist decode | wl-copy")
                (mkIf useRofi "$mod, D, exec, uwsm app -- rofi -show drun")
                (mkIf useRofi "$mod, BACKSPACE, exec, uwsm app -- logoutlaunch")
                (mkIf useScreenshots "$mod, S, exec, uwsm app -- screenshot")
                (mkIf useScreenshots "$mod SHIFT, D, exec, uwsm app -- fullscreenshot")
                (mkIf useMusic "$mod, P, exec, uwsm app -- mpc toggle")
                (mkIf useMusic "$mod, COMMA, exec, uwsm app -- mpc prev")
                (mkIf useMusic ''$mod SHIFT, COMMA, exec, uwsm app -- mpc seek "0%"'')
                (mkIf useMusic "$mod, PERIOD, exec, uwsm app -- mpc next")
                (mkIf useMusic "$mod SHIFT, PERIOD, exec, uwsm app -- mpc repeat")
                (mkIf useObs "$mod, O, exec, uwsm app -- obs")
                (mkIf useObs "SHIFT, F8, pass, ^(com\.obsproject\.Studio)$")
                (mkIf useObs "SHIFT, F9, pass, ^(com\.obsproject\.Studio)$")
                (mkIf useObs "SHIFT, F10, pass, ^(com\.obsproject\.Studio)$")
                (mkIf useObs "SHIFT, F11, pass, ^(com\.obsproject\.Studio)$")

                # Move/resize windows with mod + LMB/RMB and dragging
                (mkIf useMusic ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
                (mkIf useMusic ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
                (mkIf useMusic ", XF86AudioAudioPrev, exec, uwsm app -- mpc prev")
                (mkIf useMusic ", XF86AudioAudioNext, exec, uwsm app -- mpc next")
                (mkIf useMusic ", XF86AudioAudioPause, exec, uwsm app -- mpc pause")
                (mkIf useMusic ", XF86AudioAudioPlay, exec, uwsm app -- mpc play")
                (mkIf useMusic ", XF86AudioAudioStop, exec, uwsm app -- mpc stop")
                (mkIf useMusic ", XF86AudioAudioRewind, exec, uwsm app -- mpc seek -10")
                (mkIf useMusic ", XF86AudioAudioForward, exec, uwsm app -- mpc seek +10")
                (mkIf isLaptop ", XF86MonBrightnessDown, exec, uwsm app -- brightnessctl set 1%-")
                (mkIf isLaptop ", XF86MonBrightnessUp, exec, uwsm app -- brightnessctl set 1%+")
                (mkIf isLaptop "SHIFT, XF86MonBrightnessDown, exec, uwsm app -- brightnessctl set 5%-")
                (mkIf isLaptop "SHIFT, XF86MonBrightnessUp, exec, uwsm app -- brightnessctl set 5%+")
                (mkIf (useMusic && useKitty) ", XF86AudioAudioMedia, exec, uwsm app -- kitty ncmpcpp")
              ];

              bindl = mkIf isLaptop [
                ", switch:on:Lid Switch, exec, luwsm app -- idhandle on"
                ", switch:off:Lid Switch, exec, uwsm app -- lidhandle off"
              ];

              binde = [
                # Move focus with vim keys
                "$mod, H, movefocus, l"
                "$mod, L, movefocus, r"
                "$mod, K, movefocus, u"
                "$mod, J, movefocus, d"
                "$mod ALT, H, movewindow, l"
                "$mod ALT, L, movewindow, r"
                "$mod ALT, K, movewindow, u"
                "$mod ALT, J, movewindow, d"
                "$mod SHIFT, L, resizeactive, 10 0"
                "$mod SHIFT, H, resizeactive, -10 0"
                "$mod SHIFT, K, resizeactive, 0 -10"
                "$mod SHIFT, J, resizeactive, 0 10"
                "$mod, LEFT, workspace, -1"
                "$mod, RIGHT, workspace, +1"

                (mkIf useMusic ", XF86AudioRaiseVolume, exec, uwsm app -- wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+")
                (mkIf useMusic ", XF86AudioLowerVolume, exec, uwsm app -- wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
              ];

              bindm = [
                "$mod ALT, mouse:272, movewindow"
                "$mod ALT, mouse:273, resizewindow"
              ];
            };
            extraConfig = let
              machineConfig =
                if machine == "desktop"
                then ''
                  monitor = DP-1,1920x1080@240,1920x0,1
                  workspace = 1, monitor:DP-1, default:true, persistent:true
                  workspace = 2, monitor:DP-1, persistent:true
                  workspace = 3, monitor:DP-1, persistent:true
                ''
                else ''
                  monitor = eDP-1,1920x1080,0x0,1
                  workspace = 1, monitor:eDP-1, default:true, persistent:true
                '';
              waybar =
                if useWaybar
                then "exec-once = uwsm app -- waybar-watch"
                else "";
              swaync =
                if useSwaync
                then "exec-once = uwsm app -- swaync"
                else "";
              firefox =
                if useFirefox
                then ''
                  windowrulev2 = center 1,class:(firefox)
                  windowrulev2 = size 80% 80%,class:(firefox)
                  windowrulev2 = unset,title:^(.*)(Firefox)$
                ''
                else "";
              davinci =
                if useDavinci
                then ''
                  windowrulev2 = unset,class:(resolve),title:(resolve)
                  windowrulev2 = tile,title:^(DaVinci Resolve)(.*)$
                ''
                else "";
              blueman =
                if useBlueman
                then ''
                  exec-once = uwsm app -- blueman-applet
                  windowrulev2 = float,class:^(blueman-manager)$
                ''
                else "";
              nm =
                if useNm
                then ''
                  exec-once = uwsm app -- nm-applet --indicator
                  windowrulev2 = float,class:^(nm-applet)$
                  windowrulev2 = float,class:^(nm-connection-editor)$
                ''
                else "";
              torrent =
                if useTorrent
                then ''
                  exec-once = uwsm app -- mullvad-vpn
                ''
                else "";
              kitty =
                if useKitty
                then ''
                  windowrule = opacity 0.92,kitty
                ''
                else "";
              rofi =
                if useRofi
                then ''
                  windowrule = float,Rofi
                ''
                else "";
              swayidle =
                if useSwayidle
                then ''
                  exec-once = uwsm app -- detectidle
                ''
                else "";
              swayaudioidle =
                if useSwayAudioIdle
                then ''
                  exec-once = uwsm app -- sway-audio-idle-inhibit
                ''
                else "";
              ssh =
                if useSsh
                then ''
                  exec-once = uwsm app -- sshagent
                ''
                else "";
              udiskie =
                if useUdiskie
                then ''
                  exec-once = uwsm app -- udiskie &
                ''
                else "";
            in ''
              ${machineConfig}

              env = XCURSOR_SIZE,24
              env = XDG_SESSION_TYPE,wayland
              env = XDG_SESSION_DESKTOP,Hyprland
              env = XDG_CURRENT_DESKTOP,Hyprland
              env = MOZ_ENABLE_WAYLAND,1

              bind = CTRL ALT_L, V, submap,passthrough
              submap = passthrough
              bind = CTRL ALT_L, V, submap,reset
              submap = reset

              exec-once = uwsm app -- wl-paste --type text --watch cliphist store
              exec-once = uwsm app -- wl-paste --type image --watch cliphist store
              exec-once = uwsm app -- wallpaper
              exec-once = uwsm app -- polkitagent

              windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$

              ${kitty}
              ${rofi}
              ${waybar}
              ${swaync}
              ${swayidle}
              ${swayaudioidle}
              ${udiskie}
              ${ssh}
              ${firefox}
              ${davinci}
              ${blueman}
              ${nm}
              ${torrent}
            '';
          };
        };
      };
    };
  }
