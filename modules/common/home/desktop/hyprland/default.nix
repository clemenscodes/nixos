{
  pkgs,
  inputs,
  machine,
  ...
}: {
  home = {
    packages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      brightnessctl
      swww
    ];
  };
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        systemd = {
          enable = false;
        };
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        xwayland = {
          enable = true;
        };
        plugins = [];
        settings = {
          input = {
            kb_layout = "de";
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
            drop_shadow = true;
            shadow_range = 4;
            shadow_render_power = 3;
            "col.shadow" = "rgba(1a1a1aee)";
            blur = {
              enabled = true;
              size = 1;
              noise = 0.12;
              brightness = 1.423;
              contrast = 1.309;
              passes = 2;
              special = false;
            };
          };
          master = {
            new_is_master = true;
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

          plugin = {
            csgo-vulkan-fix = {
              res_w = 1680;
              res_h = 1050;
              class = "cs2";
            };
          };

          "$mod" = "SUPER";

          bind = [
            "$mod, RETURN, exec, kitty"
            "$mod, V, exec, kitty nvim"
            "$mod SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
            "$mod, R, exec, kitty lf"
            "$mod, E, exec, kitty neomutt"
            "$mod SHIFT, R, exec, kitty btop"
            "$mod, D, exec, rofi -show drun"
            "$mod, W, exec, $BROWSER"
            "$mod, Q, killactive"
            "$mod, B, exec, waybar-toggle"
            "$mod, U, exec, hyprpicker"
            "$mod SHIFT, B, exec, waybar-reload"
            "$mod, N, exec, swaync-client -t -sw"
            "$mod, M, exec, kitty ncmpcpp"
            "$mod, O, exec, obs"
            "$mod SHIFT, K, exec, kitty calcurse"
            "$mod, BACKSPACE, exec, logoutlaunch"
            "$mod, P, exec, mpc toggle"
            "$mod, S, exec, screenshot"
            "$mod SHIFT, D, exec, fullscreenshot"
            "$mod, COMMA, exec, mpc prev"
            ''$mod SHIFT, COMMA, exec, mpc seek "0%"''
            "$mod, PERIOD, exec, mpc next"
            "$mod SHIFT, PERIOD, exec, mpc repeat"
            "$mod, C, exec, hyprctl reload"
            "$mod SHIFT, C, exit"
            "$mod, F, fullscreen"
            "$mod, SPACE, layoutmsg, swapwithmaster"
            "$mod SHIFT, F, togglefloating,"
            "SHIFT, F9, pass, ^(com\.obsproject\.Studio)$"
            "SHIFT, F10, pass, ^(com\.obsproject\.Studio)$"
            "SHIFT, F11, pass, ^(com\.obsproject\.Studio)$"

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

            # Move/resize windows with mod + LMB/RMB and dragging
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ", XF86AudioAudioPrev, exec, mpc prev"
            ", XF86AudioAudioNext, exec, mpc next"
            ", XF86AudioAudioPause, exec, mpc pause"
            ", XF86AudioAudioPlay, exec, mpc play"
            ", XF86AudioAudioStop, exec, mpc stop"
            ", XF86AudioAudioRewind, exec, mpc seek -10"
            ", XF86AudioAudioForward, exec, mpc seek +10"
            ", XF86AudioAudioMedia, exec, kitty ncmpcpp"
            ", XF86AudioAudioMedia, exec, kitty ncmpcpp"
            ", XF86MonBrightnessDown, exec, brightnessctl set 1%-"
            ", XF86MonBrightnessUp, exec, brightnessctl set 1%+"
            "SHIFT, XF86MonBrightnessDown, exec, brightnessctl set 5%-"
            "SHIFT, XF86MonBrightnessUp, exec, brightnessctl set 5%+"
            "$mod, XF86MonBrightnessDown, exec, hyprshade on blue-light-filter"
            "$mod, XF86MonBrightnessUp, exec, hyprshade off"
          ];

          bindl = [
            ", switch:on:Lid Switch, exec, lidhandle on"
            ", switch:off:Lid Switch, exec, lidhandle off"
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

            ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ];

          bindm = [
            "$mod ALT, mouse:272, movewindow"
            "$mod ALT, mouse:273, resizewindow"
          ];
        };
        extraConfig = let
          machineConfig =
            if machine == "desktop"
            then
              /*
              hyprlang
              */
              ''
                monitor = DP-1,1920x1080@240,1920x0,1
                workspace = 1, monitor:DP-1, default:true, persistent:true
                workspace = 2, monitor:DP-1, persistent:true
                workspace = 3, monitor:DP-1, persistent:true
              ''
            else
              /*
              hyprlang
              */
              ''
                monitor = eDP-1,1920x1080,1920x0,1
                workspace = 1, monitor:eDP-1, default:true, persistent:true
              '';
        in
          /*
          hyprlang
          */
          ''
            ${machineConfig}

            exec-once = waybar-watch
            exec-once = swaync
            exec-once = blueman-applet
            exec-once = nm-applet --indicator
            exec-once = udiskie &
            exec-once = wl-paste --type text --watch cliphist store
            exec-once = wl-paste --type image --watch cliphist store
            exec-once = detectidle
            exec-once = sway-audio-idle-inhibit
            exec-once = wallpaper
            exec-once = polkitagent
            exec-once = sshagent
            exec-once = lact daemon
            exec-once = ydotoold

            env = XCURSOR_SIZE,24
            env = XDG_SESSION_TYPE,wayland
            env = XDG_SESSION_DESKTOP,Hyprland
            env = XDG_CURRENT_DESKTOP,Hyprland
            env = QT_QPA_PLATFORM,wayland-egl
            env = QT_QPA_PLATFORMTHEME,gtk
            env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
            env = QT_AUTO_SCREEN_SCALE_FACTOR,1
            env = MOZ_ENABLE_WAYLAND,1

            windowrule = float,Rofi
            windowrule = opacity 0.88,kitty
            windowrule = opacity 0.97,jetbrains-idea
            windowrule = opacity 0.88,org.pwmt.zathura

            windowrulev2 = center 1,class:(firefox)
            windowrulev2 = size 80% 80%,class:(firefox)
            windowrulev2 = unset,title:^(.*)(Firefox)$

            windowrulev2 = float,class:^(blueman-manager)$
            windowrulev2 = float,class:^(nm-applet)$
            windowrulev2 = float,class:^(nm-connection-editor)$
            windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$

            windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
            windowrulev2 = noanim,class:^(xwaylandvideobridge)$
            windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
            windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

            animations {
              enabled = yes
              bezier = overshot, 0.05, 0.9, 0.1, 1.05
              bezier = smoothOut, 0.5, 0, 0.99, 0.99
              bezier = smoothIn, 0.5, -0.5, 0.68, 1.5
              animation = windows, 1, 5, overshot, slide
              animation = windowsOut, 1, 3, smoothOut
              animation = windowsIn, 1, 3, smoothOut
              animation = windowsMove, 1, 4, smoothIn, slide
              animation = border, 1, 5, default
              animation = fade, 1, 5, smoothIn
              animation = fadeDim, 1, 5, smoothIn
              animation = workspaces, 1, 6, default
            }

            bind = CTRL ALT_L, V, submap,passthrough
            submap = passthrough
            bind = CTRL ALT_L, V, submap,reset
            submap = reset
          '';
      };
    };
  };
}
