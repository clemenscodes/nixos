{
  nixpkgs,
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking.proxy;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["charles"];
    };
  };
in
  with lib; {
    options = {
      modules = {
        networking = {
          proxy = {
            charles = {
              enable = mkEnableOption "Enable charles web debugging proxy" // {default = false;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.charles.enable) {
      home = {
        packages = with pkgs; [
          charles
        ];
      };
    };
  }
