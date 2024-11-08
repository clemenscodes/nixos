{inputs}: {
  config,
  lib,
  ...
}: let
  cfg = config.modules.themes;
  isDesktop = config.modules.display.gui != "headless";
in
  with lib; {
    imports = [inputs.catppuccin.nixosModules.catppuccin];
    options = {
      modules = {
        themes = {
          catppuccin = {
            enable = mkEnableOption "Enable catppuccin theme" // {default = cfg.enable;};
            flavor = mkOption {
              type = types.enum [
                "latte"
                "frappe"
                "macchiato"
                "mocha"
              ];
              default = "macchiato";
            };
            accent = mkOption {
              type = types.enum [
                "Blue"
                "Flamingo"
                "Green"
                "Lavender"
                "Maroon"
                "Mauve"
                "Peach"
                "Pink"
                "Red"
                "Rosewater"
                "Sapphire"
                "Sky"
                "Teal"
                "Yellow"
              ];
              default = "Blue";
            };
          };
        };
      };
    };
    config = {
      catppuccin = mkIf (cfg.enable && cfg.catppuccin.enable && isDesktop) {
        inherit (cfg.catppuccin) enable flavor accent;
      };
      home-manager = {
        users = {
          ${config.modules.users.user} = {
            imports = [inputs.catppuccin.homeManagerModules.catppuccin];
            catppuccin = mkIf (cfg.enable && cfg.catppuccin.enable && isDesktop) {
              inherit (cfg.catppuccin) enable flavor accent;
            };
          };
        };
      };
    };
  }
