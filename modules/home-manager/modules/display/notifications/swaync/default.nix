{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.display.notifications;
in
  with lib; {
    options = {
      modules = {
        display = {
          notifications = {
            swaync = {
              enable = mkEnableOption "Enable swaync" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.swaync.enable) {
      home = {
        packages = with pkgs; [
          swaynotificationcenter
        ];
      };
      xdg = {
        configFile = {
          "swaync/macchiato.css" = {
            text =
              /*
              css
              */
              ''
                * {
                  all: unset;
                  font-size: 14px;
                  font-family: "Iosevka Nerd Font";
                  transition: 200ms;
                }

                .floating-notifications.background .notification-row .notification-background {
                  box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #363a4f;
                  border-radius: 12.6px;
                  margin: 18px;
                  background-color: #24273a;
                  color: #cad3f5;
                  padding: 0;
                }

                .floating-notifications.background .notification-row .notification-background .notification {
                  padding: 7px;
                  border-radius: 12.6px;
                }

                .floating-notifications.background .notification-row .notification-background .notification.critical {
                  box-shadow: inset 0 0 7px 0 #ed8796;
                }

                .floating-notifications.background .notification-row .notification-background .notification .notification-content {
                  margin: 7px;
                }

                .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
                  color: #cad3f5;
                }

                .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
                  color: #a5adcb;
                }

                .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
                  color: #cad3f5;
                }

                .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
                  min-height: 3.4em;
                }

                .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
                  border-radius: 7px;
                  color: #cad3f5;
                  background-color: #363a4f;
                  box-shadow: inset 0 0 0 1px #494d64;
                  margin: 7px;
                }

                .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
                  box-shadow: inset 0 0 0 1px #494d64;
                  background-color: #363a4f;
                  color: #cad3f5;
                }

                .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
                  box-shadow: inset 0 0 0 1px #494d64;
                  background-color: #7dc4e4;
                  color: #cad3f5;
                }

                .floating-notifications.background .notification-row .notification-background .close-button {
                  margin: 7px;
                  padding: 2px;
                  border-radius: 6.3px;
                  color: #24273a;
                  background-color: #ed8796;
                }

                .floating-notifications.background .notification-row .notification-background .close-button:hover {
                  background-color: #ee99a0;
                  color: #24273a;
                }

                .floating-notifications.background .notification-row .notification-background .close-button:active {
                  background-color: #ed8796;
                  color: #24273a;
                }

                .control-center {
                  box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #363a4f;
                  border-radius: 12.6px;
                  margin: 18px;
                  background-color: #24273a;
                  color: #cad3f5;
                  padding: 14px;
                }

                .control-center .widget-title {
                  color: #cad3f5;
                  font-size: 1.3em;
                }

                .control-center .widget-title button {
                  border-radius: 7px;
                  color: #cad3f5;
                  background-color: #363a4f;
                  box-shadow: inset 0 0 0 1px #494d64;
                  padding: 8px;
                }

                .control-center .widget-title button:hover {
                  box-shadow: inset 0 0 0 1px #494d64;
                  background-color: #5b6078;
                  color: #cad3f5;
                }

                .control-center .widget-title button:active {
                  box-shadow: inset 0 0 0 1px #494d64;
                  background-color: #7dc4e4;
                  color: #24273a;
                }

                .control-center .notification-row .notification-background {
                  border-radius: 7px;
                  color: #cad3f5;
                  background-color: #363a4f;
                  box-shadow: inset 0 0 0 1px #494d64;
                  margin-top: 14px;
                }

                .control-center .notification-row .notification-background .notification {
                  padding: 7px;
                  border-radius: 7px;
                }

                .control-center .notification-row .notification-background .notification.critical {
                  box-shadow: inset 0 0 7px 0 #ed8796;
                }

                .control-center .notification-row .notification-background .notification .notification-content {
                  margin: 7px;
                }

                .control-center .notification-row .notification-background .notification .notification-content .summary {
                  color: #cad3f5;
                }

                .control-center .notification-row .notification-background .notification .notification-content .time {
                  color: #a5adcb;
                }

                .control-center .notification-row .notification-background .notification .notification-content .body {
                  color: #cad3f5;
                }

                .control-center .notification-row .notification-background .notification > *:last-child > * {
                  min-height: 3.4em;
                }

                .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
                  border-radius: 7px;
                  color: #cad3f5;
                  background-color: #181926;
                  box-shadow: inset 0 0 0 1px #494d64;
                  margin: 7px;
                }

                .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
                  box-shadow: inset 0 0 0 1px #494d64;
                  background-color: #363a4f;
                  color: #cad3f5;
                }

                .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
                  box-shadow: inset 0 0 0 1px #494d64;
                  background-color: #7dc4e4;
                  color: #cad3f5;
                }

                .control-center .notification-row .notification-background .close-button {
                  margin: 7px;
                  padding: 2px;
                  border-radius: 6.3px;
                  color: #24273a;
                  background-color: #ee99a0;
                }

                .control-center .notification-row .notification-background .close-button:hover {
                  background-color: #ed8796;
                  color: #24273a;
                }

                .control-center .notification-row .notification-background .close-button:active {
                  background-color: #ed8796;
                  color: #24273a;
                }

                .control-center .notification-row .notification-background:hover {
                  box-shadow: inset 0 0 0 1px #494d64;
                  background-color: #8087a2;
                  color: #cad3f5;
                }

                .control-center .notification-row .notification-background:active {
                  box-shadow: inset 0 0 0 1px #494d64;
                  background-color: #7dc4e4;
                  color: #cad3f5;
                }

                progressbar,
                progress,
                trough {
                  border-radius: 12.6px;
                }

                progressbar {
                  box-shadow: inset 0 0 0 1px #494d64;
                }

                .notification.critical progress {
                  background-color: #ed8796;
                }

                .notification.low progress,
                .notification.normal progress {
                  background-color: #8aadf4;
                }

                trough {
                  background-color: #363a4f;
                }

                .control-center trough {
                  background-color: #494d64;
                }

                .control-center-dnd {
                  margin-top: 5px;
                  border-radius: 8px;
                  background: #363a4f;
                  border: 1px solid #494d64;
                  box-shadow: none;
                }

                .control-center-dnd:checked {
                  background: #363a4f;
                }

                .control-center-dnd slider {
                  background: #494d64;
                  border-radius: 8px;
                }

                .widget-dnd {
                  margin: 0px;
                  font-size: 1.1rem;
                }

                .widget-dnd > switch {
                  font-size: initial;
                  border-radius: 8px;
                  background: #363a4f;
                  border: 1px solid #494d64;
                  box-shadow: none;
                }

                .widget-dnd > switch:checked {
                  background: #363a4f;
                }

                .widget-dnd > switch slider {
                  background: #494d64;
                  border-radius: 8px;
                  border: 1px solid #6e738d;
                }
              '';
          };
          "swaync/style.css" = {
            text =
              /*
              css
              */
              ''
                @define-color cc-bg rgba(26, 27, 38, 1);
                @define-color noti-border-color rgba(255, 255, 255, 0.15);
                @define-color noti-bg rgb(17, 17, 27);
                @define-color noti-bg-darker rgb(43, 43, 57);
                @define-color noti-bg-hover rgb(27, 27, 43);
                @define-color noti-bg-focus rgba(27, 27, 27, 0.6);
                @define-color noti-close-bg rgba(255, 255, 255, 0.1);
                @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);
                @define-color text-color rgba(169, 177, 214, 1);
                @define-color text-color-disabled rgb(150, 150, 150);
                @define-color bg-selected rgb(0, 128, 255);

                * {
                    font-family: "${osConfig.modules.fonts.defaultFont} ${builtins.toString osConfig.modules.fonts.size}";
                    transition: 200ms;
                    background: transparent;
                }

                .control-center .notification-row:focus,
                .control-center .notification-row:hover {
                    opacity: 1;
                    background: @noti-bg-darker
                }

                .notification-row {
                    outline: none;
                    margin: 10px;
                    padding: 0;
                }

                .notification {
                    background: transparent;
                    padding: 0;
                    margin: 0px;
                }

                .notification-content {
                    background: @cc-bg;
                    padding: 10px;
                    border-radius: 5px;
                    border: 2px solid #34548a;
                    margin: 0;
                }

                .notification-default-action {
                    margin: 0;
                    padding: 0;
                    border-radius: 5px;
                }

                .close-button {
                    background: #f7768e;
                    color: @cc-bg;
                    text-shadow: none;
                    padding: 0;
                    border-radius: 5px;
                    margin-top: 5px;
                    margin-right: 5px;
                }

                .close-button:hover {
                    box-shadow: none;
                    background: #f7768e;
                    transition: all .15s ease-in-out;
                    border: none
                }

                .notification-action {
                    border: 2px solid #34548a;
                    border-top: none;
                    border-radius: 5px;
                }

                .notification-default-action:hover,
                .notification-action:hover {
                    color: #7aa2f7;
                    background: #7aa2f7
                }

                .notification-default-action {
                    border-radius: 5px;
                    margin: 0px;
                }

                .notification-default-action:not(:only-child) {
                    border-bottom-left-radius: 7px;
                    border-bottom-right-radius: 7px
                }

                .notification-action:first-child {
                    border-bottom-left-radius: 10px;
                    background: #1b1b2b
                }

                .notification-action:last-child {
                    border-bottom-right-radius: 10px;
                    background: #1b1b2b
                }

                .inline-reply {
                    margin-top: 8px
                }

                .inline-reply-entry {
                    background: @noti-bg-darker;
                    color: @text-color;
                    caret-color: @text-color;
                    border: 1px solid @noti-border-color;
                    border-radius: 5px
                }

                .inline-reply-button {
                    margin-left: 4px;
                    background: @noti-bg;
                    border: 1px solid @noti-border-color;
                    border-radius: 5px;
                    color: @text-color
                }

                .inline-reply-button:disabled {
                    background: initial;
                    color: @text-color-disabled;
                    border: 1px solid transparent
                }

                .inline-reply-button:hover {
                    background: @noti-bg-hover
                }

                .body-image {
                    margin-top: 6px;
                    background-color: #fff;
                    border-radius: 5px
                }

                .summary {
                    font-size: 16px;
                    font-weight: 700;
                    background: transparent;
                    color: rgba(158, 206, 106, 1);
                    text-shadow: none
                }

                .time {
                    font-size: 16px;
                    font-weight: 700;
                    background: transparent;
                    color: @text-color;
                    text-shadow: none;
                    margin-right: 18px
                }

                .body {
                    font-size: 15px;
                    font-weight: 400;
                    background: transparent;
                    color: @text-color;
                    text-shadow: none
                }

                .control-center {
                    background: @cc-bg;
                    border: 2px solid #34548a;
                    border-radius: 5px;
                }

                .control-center-list {
                    background: transparent
                }

                .control-center-list-placeholder {
                    opacity: .5
                }

                .floating-notifications {
                    background: transparent
                }

                .widget-title {
                    color: #7aa2f7;
                    background: @noti-bg-darker;
                    padding: 5px 10px;
                    margin: 10px 10px 5px 10px;
                    font-size: 1.5rem;
                    border-radius: 5px;
                }

                .widget-title>button {
                    font-size: 1rem;
                    color: @text-color;
                    text-shadow: none;
                    background: @noti-bg;
                    box-shadow: none;
                    border-radius: 5px;
                }

                .widget-title>button:hover {
                    background: #f7768e;
                    color: @cc-bg;
                }

                .widget-dnd {
                    background: @noti-bg-darker;
                    padding: 5px 10px;
                    margin: 10px 10px 5px 10px;
                    border-radius: 5px;
                    font-size: large;
                    color: #7aa2f7;
                }

                .widget-dnd>switch {
                    border-radius: 5px;
                    background: #7aa2f7;
                }

                .widget-dnd>switch:checked {
                    background: #f7768e;
                    border: 1px solid #f7768e;
                }

                .widget-dnd>switch slider {
                    background: @cc-bg;
                    border-radius: 5px
                }

                .widget-dnd>switch:checked slider {
                    background: @cc-bg;
                    border-radius: 5px
                }

                .widget-label {
                    margin: 10px 10px 5px 10px;
                }

                .widget-label>label {
                    font-size: 1rem;
                    color: @text-color;
                }

                .widget-mpris {
                    color: @text-color;
                    background: @noti-bg-darker;
                    padding: 5px 10px;
                    margin: 10px 10px 5px 10px;
                    border-radius: 5px;
                }

                .widget-mpris > box > button {
                    border-radius: 5px;
                }

                .widget-mpris-player {
                    padding: 5px 10px;
                    margin: 10px
                }

                .widget-mpris-player > box > image {
                    margin-right: 36px;
                }

                .widget-mpris-title {
                    font-weight: 700;
                    font-size: 1.25rem
                }

                .widget-mpris-subtitle {
                    font-size: 1.1rem
                }

                .widget-buttons-grid {
                    font-size: x-large;
                    padding: 5px;
                    margin: 10px 10px 5px 10px;
                    border-radius: 5px;
                    background: @noti-bg-darker;
                }

                .widget-buttons-grid>flowbox>flowboxchild>button {
                    margin: 3px;
                    background: @cc-bg;
                    padding: 6px;
                    border-radius: 5px;
                    color: @text-color
                }

                .widget-buttons-grid>flowbox>flowboxchild>button:hover {
                    background: rgba(122, 162, 247, 1);
                    color: @cc-bg;
                }

                .widget-menubar>box>.menu-button-bar>button {
                    border: none;
                    background: transparent
                }

                .topbar-buttons>button {
                    border: none;
                    background: transparent
                }

                .widget-volume {
                    background: @noti-bg-darker;
                    padding: 5px;
                    margin: 10px 10px 5px 10px;
                    border-radius: 5px;
                    font-size: x-large;
                    color: @text-color;
                }

                .widget-volume>box>button {
                    background: #7aa2f7;
                    border: none
                }

                .per-app-volume {
                    background-color: @noti-bg;
                    padding: 4px 8px 8px;
                    margin: 0 8px 8px;
                    border-radius: 5px;
                }

                .widget-backlight {
                    background: @noti-bg-darker;
                    padding: 12px;
                    margin: 10px 10px 5px 10px;
                    border-radius: 5px;
                    font-size: x-large;
                    color: @text-color
                }

              '';
          };
          "swaync/config.json" = {
            text =
              /*
              json
              */
              ''
                {
                  "positionX": "right",
                  "positionY": "top",
                  "cssPriority": "user",
                  "control-center-margin-top": 10,
                  "control-center-margin-bottom": 10,
                  "control-center-margin-right": 10,
                  "control-center-margin-left": 10,
                  "notification-icon-size": 64,
                  "notification-body-image-height": 100,
                  "notification-body-image-width": 200,
                  "timeout": 10,
                  "timeout-low": 5,
                  "timeout-critical": 0,
                  "fit-to-screen": true,
                  "control-center-width": 500,
                  "control-center-height": 900,
                  "notification-window-width": 500,
                  "keyboard-shortcuts": true,
                  "image-visibility": "when-available",
                  "transition-time": 200,
                  "hide-on-clear": false,
                  "hide-on-action": false,
                  "script-fail-notify": true,
                  "widgets": [
                    "title",
                    "mpris",
                    "dnd",
                    "notifications"
                  ],
                  "widget-config": {
                    "title": {
                      "text": "Notification Center",
                      "clear-all-button": true,
                      "button-text": "󰆴 Clear All"
                    },
                    "dnd": {
                      "text": "Do Not Disturb"
                    },
                    "label": {
                      "max-lines": 1,
                      "text": "Notification Center"
                    },
                    "mpris": {
                      "image-size": 96,
                      "image-radius": 7
                    }
                  }
                }
              '';
          };
        };
      };
    };
  }
