{lib, ...}: {config, ...}: let
  cfg = config.modules.gaming.emulation;
in {
  options = {
    modules = {
      gaming = {
        emulation = {
          rpcs3 = {
            enable = lib.mkEnableOption "Enable rpcs3 emulation (PlayStation 3)" // {default = cfg.enable;};
          };
        };
      };
    };
  };
}
