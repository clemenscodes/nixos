{inputs}: {
  config,
  lib,
  nixpkgs,
  system,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [inputs.home-manager.nixosModules.home-manager];
    options = {
      modules = {
        home-manager = {
          enable = mkEnableOption "Enable home-manager" // {default = cfg.enable;};
        };
      };
    };
    config = mkIf (cfg.enable && cfg.home-manager.enable) {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs nixpkgs system;};
        backupFileExtension = "home-manager-backup";
        users = {
          ${cfg.users.user} = {
            imports = [(import ./modules {inherit inputs;})];
          };
        };
      };
    };
  }
