{inputs}: {
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development.cardano;
in
  with lib; {
    options = {
      modules = {
        development = {
          cardano = {
            node = {
              enable = mkEnableOption "Enable cardano-node" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.node.enable) {
      home = {
        packages = with inputs.cardano-node.packages.${system}; [
          cardano-node
        ];
      };
    };
  }
