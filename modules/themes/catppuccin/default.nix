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
                "blue"
                "flamingo"
                "green"
                "lavender"
                "maroon"
                "mauve"
                "peach"
                "pink"
                "red"
                "rosewater"
                "sapphire"
                "sky"
                "teal"
                "yellow"
              ];
              default = "blue";
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
