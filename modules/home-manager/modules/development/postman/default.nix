{
  nixpkgs,
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["postman"];
    };
  };
in
  with lib; {
    options = {
      modules = {
        development = {
          postman = {
            enable = mkEnableOption "Enable postman support" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.postman.enable) {
      home = {
        packages = with pkgs; [postman];
      };
    };
  }
