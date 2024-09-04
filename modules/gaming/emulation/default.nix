{
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming;
in
  with lib; {
    imports = [
      ./pcsx2
      ./rpcs3
    ];
    options = {
      modules = {
        gaming = {
          emulation = {
            enable = mkEnableOption "Enable emulation" // {default = cfg.enable;};
          };
        };
      };
    };
  }
