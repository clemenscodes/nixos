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
            cli = {
              enable = mkEnableOption "Enable cardano-cli" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.cli.enable) {
      home = {
        packages = with inputs.cardano-cli.legacyPackages.${system}; [
          cardano-cli
        ];
      };
    };
  }
