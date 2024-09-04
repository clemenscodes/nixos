{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with pkgs; let
  cfg = config.modules.gaming.emulation;
  ps3bios = import ./firmware {inherit pkgs;};
in {
  options = {
    modules = {
      gaming = {
        emulation = {
          rpcs3 = {
            enable = mkEnableOption "Enable rpcs3 emulation (PlayStation 3)" // {default = cfg.enable;};
          };
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.rpcs3.enable) {
    home-manager = mkIf (config.modules.home-manager.enable) {
      users = {
        ${config.modules.users.user} = {
          home = {
            packages = [rpcs3];
            file = {
              ".config/rpcs3/bios" = {
                source = "${ps3bios}/bios";
              };
            };
          };
        };
      };
    };
  };
}
