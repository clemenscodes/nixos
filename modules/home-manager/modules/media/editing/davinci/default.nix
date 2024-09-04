{
  nixpkgs,
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.editing;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
  with pkgs;
  with lib; {
    options = {
      modules = {
        media = {
          editing = {
            davinci = {
              enable = mkEnableOption "Enable DaVinci Resolve" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.davinci.enable) {
      home = {
        packages = [davinci-resolve];
      };
      xdg = {
        desktopEntries = {
          resolve = {
            name = "Davinci Resolve";
            genericName = "Video Editor";
            exec = "env QT_QPA_PLATFORM=xcb ${davinci-resolve}/bin/davinci-resolve %u";
            icon = "DV_Resolve";
            terminal = false;
            type = "Application";
            categories = ["AudioVideo"];
            mimeType = ["application/x-resolveproj"];
          };
        };
      };
    };
  }
