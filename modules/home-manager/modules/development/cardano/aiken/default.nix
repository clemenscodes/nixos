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
            aiken = {
              enable = mkEnableOption "Enable Aiken Cardano smart contract development support" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.aiken.enable) {
      home = {
        packages = with inputs.aiken.packages.${system}; [
          aiken
        ];
      };
    };
  }
