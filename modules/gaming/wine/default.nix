{
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming;
in
  with lib; {
    imports = [
      ./wc3
    ];
    options = {
      modules = {
        gaming = {
          wine = {
            enable = mkEnableOption "Enable wine" // {default = cfg.enable;};
          };
        };
      };
    };
  }
