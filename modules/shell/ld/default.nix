{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.shell;
in {
  options = {
    modules = {
      shell = {
        ld = {
          enable = lib.mkEnableOption "Enable nix-ld to fix many binary errors" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.ld.enable) {
    programs = {
      nix-ld = {
        enable = cfg.ld.enable;
        package = pkgs.nix-ld-rs;
        libraries = [
          pkgs.webkitgtk_4_1
          pkgs.gtk3
          pkgs.cairo
          pkgs.gdk-pixbuf
          pkgs.glib.dev
          pkgs.dbus
          pkgs.openssl_3
          pkgs.stdenv.cc.cc
          pkgs.systemd
          pkgs.pkg-config
        ];
      };
    };
  };
}
