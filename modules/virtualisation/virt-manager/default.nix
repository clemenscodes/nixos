{lib, ...}: {config, ...}: let
  cfg = config.modules.virtualisation;
in {
  options = {
    modules = {
      virtualisation = {
        virt-manager = {
          enable = lib.mkEnableOption "Enable virt-manager" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.virt-manager.enable) {
    programs = {
      virt-manager = {
        inherit (cfg.virt-manager) enable;
      };
    };
  };
}
