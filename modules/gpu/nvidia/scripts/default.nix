{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.gpu;
in
  with lib; {
    config = mkIf (cfg.enable && cfg.nvidia.enable) {
      environment = {
        systemPackages = [
          (import ./nvidiagpuinfo {inherit pkgs;})
        ];
      };
    };
  }
