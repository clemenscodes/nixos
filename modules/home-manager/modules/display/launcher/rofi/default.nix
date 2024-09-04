{
  pkgs,
  osConfig,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display.launcher;
in
  with lib; {
    options = {
      modules = {
        display = {
          launcher = {
            rofi = {
              enable = mkEnableOption "Enable launchers" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.rofi.enable) {
      home = {
        packages = [
          (import ./logoutlaunch {inherit pkgs;})
          (import ./signout {inherit pkgs osConfig;})
        ];
      };
      programs = {
        rofi = {
          enable = cfg.rofi.enable;
          package = pkgs.rofi-wayland;
          terminal = "${config.modules.terminal.defaultTerminal}";
          font = "${osConfig.modules.fonts.defaultFont} ${builtins.toString osConfig.modules.fonts.size}";
        };
      };
      xdg = {
        configFile = {
          "rofi/config.rasi" = {
            text =
              /*
              rasi
              */
              ''
                configuration {
                  /*---------- General setting ----------*/
                  modi: "drun,run,window";
                  case-sensitive: false;
                  cycle: true;
                  filter: "";
                  scroll-method: 0;
                  normalize-match: true;

                  /*---------- Matching setting ----------*/
                  matching: "normal";
                  tokenize: true;

                  /*---------- Drun settings ----------*/
                  drun-categories: "";
                  drun-match-fields: "name,generic,exec,categories,keywords";
                  drun-isplay-format: "{icon} {name}";
                  drun-show-actions: false;
                  drun-url-launcher: "xdg-open";
                  drun-use-desktop-cache: false;
                  drun-reload-desktop-cache: false;
                  drun {
                    /** Parse user desktop files. */
                    parse-user:   true;
                    /** Parse system desktop files. */
                    parse-system: true;
                  }

                  /*---------- Run settings ----------*/
                  run-command: "{cmd}";
                  run-list-command: "";
                  run-shell-command: "{terminal} {cmd}";

                  /*---------- Fallback Icon ----------*/
                  run,drun {
                  	fallback-icon: "application-x-addon";
                  }

                  /*---------- Window switcher settings ----------*/
                  window-match-fields: "title,class,role,name,desktop";
                  window-command: "wmctrl -i -R {window}";
                  window-format: "{w} - {c} - {t:0}";
                  window-thumbnail: false;

                  /*---------- History and Sorting ----------*/
                  disable-history: false;
                  sorting-method: "normal";
                  max-history-size: 25;

                  /*---------- Display setting ----------*/
                  display-drun: "";
                  display-run: "";
                  display-filebrowser: "";
                  display-window: "";

                  /*---------- Misc setting ----------*/
                  icon-theme: "Papirus-Dark";
                  show-icons: true;
                  sort: false;
                  threads: 0;
                  click-to-exit: true;

                  /*---------- File browser settings ----------*/
                  filebrowser {
                    directories-first: true;
                    sorting-method:    "name";
                  }

                  /*---------- Other settings ----------*/
                  timeout {
                    action: "kb-cancel";
                    delay:  0;
                  }

                  /*---------- Keybindings ----------*/
                  kb-row-up: "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
                  kb-row-down: "Down,Control+j";
                  kb-accept-entry: "Control+m,Return,KP_Enter";
                  kb-remove-to-eol: "Control+Shift+e";
                  kb-mode-next: "Shift+Right,Control+Tab,Control+l";
                  kb-mode-previous: "Shift+Left,Control+Shift+Tab,Control+h";
                  kb-remove-char-back: "BackSpace";
                  kb-primary-paste: "Control+V,Shift+Insert";
                  kb-secondary-paste: "Control+v,Insert";
                  kb-clear-line: "Control+w";
                  kb-move-front: "Control+a";
                  kb-move-end: "Control+e";
                  kb-move-word-back: "Alt+b,Control+Left";
                  kb-move-word-forward: "Alt+f,Control+Right";
                  kb-move-char-back: "Left,Control+b";
                  kb-move-char-forward: "Right,Control+f";
                  kb-remove-word-back: "Control+Alt+h,Control+BackSpace";
                  kb-remove-word-forward: "Control+Alt+d";
                  kb-remove-char-forward: "Delete,Control+d";
                  kb-remove-to-sol: "Control+u";
                  kb-accept-custom: "Control+Return";
                  kb-accept-custom-alt: "Control+Shift+Return";
                  kb-accept-alt: "Shift+Return";
                    kb-delete-entry: "Shift+Delete";
                  kb-mode-complete: "Control+0";
                  kb-page-prev: "Page_Up";
                  kb-page-next: "Page_Down";
                  kb-row-first: "Home,KP_Home";
                  kb-row-last: "End,KP_End";
                  kb-row-select: "Control+space";
                  kb-screenshot: "Alt+S";
                  kb-ellipsize: "Alt+period";
                  kb-toggle-case-sensitivity: "grave,dead_grave";
                  kb-toggle-sort: "Alt+grave";
                  kb-cancel: "Escape,Control+g,Control+bracketleft";
                  kb-custom-1: "Alt+1";
                  kb-custom-2: "Alt+2";
                  kb-custom-3: "Alt+3";
                  kb-custom-4: "Alt+4";
                  kb-custom-5: "Alt+5";
                  kb-custom-6: "Alt+6";
                  kb-custom-7: "Alt+7";
                  kb-custom-8: "Alt+8";
                  kb-custom-9: "Alt+9";
                  kb-custom-10: "Alt+0";
                  kb-custom-11: "Alt+exclam";
                  kb-custom-12: "Alt+at";
                  kb-custom-13: "Alt+numbersign";
                  kb-custom-14: "Alt+dollar";
                  kb-custom-15: "Alt+percent";
                  kb-custom-16: "Alt+dead_circumflex";
                  kb-custom-17: "Alt+ampersand";
                  kb-custom-18: "Alt+asterisk";
                  kb-custom-19: "Alt+parenleft";
                  kb-select-1: "Super+1";
                  kb-select-2: "Super+2";
                  kb-select-3: "Super+3";
                  kb-select-4: "Super+4";
                  kb-select-5: "Super+5";
                  kb-select-6: "Super+6";
                  kb-select-7: "Super+7";
                  kb-select-8: "Super+8";
                  kb-select-9: "Super+9";
                  kb-select-10: "Super+0";
                  ml-row-left: "ScrollLeft";
                  ml-row-right: "ScrollRight";
                  ml-row-up: "ScrollUp";
                  ml-row-down: "ScrollDown";
                  me-select-entry: "MousePrimary";
                  me-accept-entry: "MouseDPrimary";
                  me-accept-custom: "Control+MouseDPrimary";
                }

                @theme "themes/catppuccin-macchiato"

                // Main //
                window {
                    height:                      590px;
                    width:                       1140px;
                    transparency:                "real";
                    fullscreen:                  false;
                    enabled:                     true;
                    cursor:                      "default";
                    spacing:                     0px;
                    padding:                     0px;
                    border:                      2px;
                    border-radius:               40px;
                    border-color:                @main-br;
                    background-color:            transparent;
                }

                mainbox {
                    enabled:                     true;
                    spacing:                     0px;
                    orientation:                 horizontal;
                    children:                    [  "inputbar" , "listbox" ];
                    background-color:            transparent;
                    background-image:            url("~/.local/share/images/wallpaper/ring.jpeg", height);
                }


                // Inputs //
                inputbar {
                    enabled:                     true;
                    width:                       640px;
                    children:                    [ "mode-switcher" , "entry" ];
                    background-color:            transparent;
                    background-image:            url("~/.local/share/images/wallpaper/ring.jpeg", height);
                }
                entry {
                    enabled:                     false;
                }


                // Modes //
                mode-switcher{
                    orientation:                 vertical;
                    enabled:                     true;
                    spacing:                     0px;
                    width:                       68px;
                    padding:                     160px 10px 160px 10px;
                    spacing:                     25px;
                    background-color:            transparent;
                    background-image:            url("~/.local/share/images/wallpaper/ring.jpeg", height);
                }
                button {
                    cursor:                      pointer;
                    border-radius:               50px;
                    background-color:            @main-bg;
                    text-color:                  @main-fg;
                }
                button selected {
                    background-color:            @main-fg;
                    text-color:                  @main-bg;
                }


                // Lists //
                listbox {
                    spacing:                     10px;
                    padding:                     30px;
                    children:                    [ "listview" ];
                    background-color:            @main-bg;
                }
                listview {
                    enabled:                     true;
                    columns:                     1;
                    cycle:                       true;
                    dynamic:                     true;
                    scrollbar:                   false;
                    layout:                      vertical;
                    reverse:                     false;
                    fixed-height:                true;
                    fixed-columns:               true;
                    cursor:                      "default";
                    background-color:            transparent;
                    text-color:                  @main-fg;
                }


                // Elements //
                element {
                    enabled:                     true;
                    spacing:                     30px;
                    padding:                     8px;
                    border-radius:               20px;
                    cursor:                      pointer;
                    background-color:            transparent;
                    text-color:                  @main-fg;
                }
                @media(max-aspect-ratio: 1.8) {
                    element {
                        orientation:             vertical;
                    }
                }
                element selected.normal {
                    background-color:            @select-bg;
                    text-color:                  @select-fg;
                }
                element-icon {
                    size:                        48px;
                    cursor:                      inherit;
                    background-color:            transparent;
                    text-color:                  inherit;
                }

                element-text {
                    vertical-align:              0.5;
                    horizontal-align:            0.0;
                    cursor:                      inherit;
                    background-color:            transparent;
                    text-color:                  inherit;
                }
              '';
          };
          "rofi/themes/catppuccin.rasi" = {
            text =
              /*
              rasi
              */
              ''
                * {
                    background:     #1E1D2FFF;
                    background-alt: #282839FF;
                    foreground:     #D9E0EEFF;
                    selected:       #7AA2F7FF;
                    active:         #ABE9B3FF;
                    urgent:         #F28FADFF;
                }
              '';
          };
          "rofi/themes/catppuccin-macchiato.rasi" = {
            text =
              /*
              rasi
              */
              ''
                * {
                  main-bg:            #11111be6;
                  main-fg:            #cdd6f4ff;
                  main-br:            #cba6f7ff;
                  main-ex:            #f5e0dcff;
                  select-bg:          #b4befeff;
                  select-fg:          #11111bff;
                  separatorcolor:     transparent;
                  border-color:       transparent;
                }
              '';
          };
          "rofi/powermenu/style.rasi" = {
            text =
              /*
              rasi
              */
              ''
                configuration {
                  show-icons:                 false;
                  /*---------- Vim Keybindings ----------*/
                  kb-row-up: "Up,k";
                  kb-row-down: "Down,j";
                  kb-row-right: "l";
                  kb-row-left: "h";
                }

                /*****----- Global Properties -----*****/
                * {
                  font: "Iosevka Nerd Font";
                }

                @import                          "../themes/catppuccin.rasi"

                /*****----- Main Window -----*****/
                window {
                    transparency:                "real";
                    location:                    center;
                    anchor:                      center;
                    fullscreen:                  false;
                    width:                       800px;
                    x-offset:                    0px;
                    y-offset:                    0px;

                    padding:                     0px;
                    border:                      0px solid;
                    border-radius:               15px;
                    border-color:                @selected;
                    cursor:                      "default";
                    background-color:            @background;
                }

                /*****----- Main Box -----*****/
                mainbox {
                    background-color:            transparent;
                    orientation:                 horizontal;
                    children:                    [ "imagebox", "listview" ];
                }

                /*****----- Imagebox -----*****/
                imagebox {
                    spacing:                     30px;
                    padding:                     30px;
                    background-color:            transparent;
                    background-image:            url("~/.local/share/images/wallpaper/street.jpg", height);
                    children:                    [ "inputbar", "dummy", "message" ];
                }

                /*****----- User -----*****/
                userimage {
                    margin:                      0px 0px;
                    border:                      10px;
                    border-radius:               10px;
                    border-color:                @background-alt;
                    background-color:            transparent;
                    background-image:            url("~/.local/share/images/wallpaper/street.jpg", height);
                }

                /*****----- Inputbar -----*****/
                inputbar {
                    padding:                     15px;
                    border-radius:               10px;
                    background-color:            @urgent;
                    text-color:                  @foreground;
                    children:                    [ "dummy", "prompt", "dummy"];
                }

                dummy {
                    background-color:            transparent;
                }

                prompt {
                    background-color:            inherit;
                    text-color:                  inherit;
                }

                /*****----- Message -----*****/
                message {
                    enabled:                     true;
                    margin:                      0px;
                    padding:                     15px;
                    border-radius:               10px;
                    background-color:            @active;
                    text-color:                  @background;
                }

                textbox {
                    background-color:            inherit;
                    text-color:                  inherit;
                    vertical-align:              0.5;
                    horizontal-align:            0.5;
                }

                /*****----- Listview -----*****/
                listview {
                    enabled:                     true;
                    columns:                     2;
                    lines:                       3;
                    cycle:                       true;
                    dynamic:                     true;
                    scrollbar:                   false;
                    layout:                      vertical;
                    reverse:                     false;
                    fixed-height:                true;
                    fixed-columns:               true;

                    spacing:                     30px;
                    margin:                      30px;
                    background-color:            transparent;
                    cursor:                      "default";
                }

                element {
                    enabled:                     true;
                    padding:                     40px 10px;
                    border-radius:               10px;
                    background-color:            @background-alt;
                    text-color:                  @foreground;
                    cursor:                      pointer;
                    font: 			 "FantasqueSansMono 20";
                }

                element-text {
                    background-color:            transparent;
                    text-color:                  inherit;
                    cursor:                      inherit;
                    vertical-align:              0.5;
                    horizontal-align:            0.5;
                }

                element selected.normal {
                    background-color:            var(selected);
                    text-color:                  var(background);
                }
              '';
          };
        };
      };
    };
  }
