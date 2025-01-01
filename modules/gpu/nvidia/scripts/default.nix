{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.gpu;
in {
  config = lib.mkIf (cfg.enable && cfg.nvidia.enable) {
    environment = {
      systemPackages = [
        (import ./nvidiagpuinfo {inherit inputs pkgs lib;})
      ];
    };
  };
}
