{
  nixpkgs,
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display.pdfviewer;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["calibre" "unrar"];
    };
    overlays = [
      (self: super: {
        calibre = super.calibre.override {
          unrarSupport = true;
        };
      })
    ];
  };
in
  with lib; {
    options = {
      modules = {
        display = {
          pdfviewer = {
            calibre = {
              enable = mkEnableOption "Enable calibre" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.calibre.enable) {
      home = {
        packages = with pkgs; [calibre];
      };
    };
  }
