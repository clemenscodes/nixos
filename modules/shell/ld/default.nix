{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell;
in
  with lib; {
    options = {
      modules = {
        shell = {
          ld = {
            enable = mkEnableOption "Enable nix-ld to fix many binary errors" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.ld.enable) {
      programs = {
        nix-ld = {
          enable = cfg.ld.enable;
          package = pkgs.nix-ld-rs;
          libraries = with pkgs; [
            webkitgtk_4_1
            gtk3
            cairo
            gdk-pixbuf
            glib.dev
            dbus
            openssl_3
            stdenv.cc.cc
            systemd
            pkg-config
          ];
        };
      };
    };
  }
