{
  inputs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.themes;
  isDesktop = config.modules.display.gui != "headless";
in {
  imports = [inputs.catppuccin.nixosModules.catppuccin];
  options = {
    modules = {
      themes = {
        catppuccin = {
          enable = lib.mkEnableOption "Enable catppuccin theme" // {default = cfg.enable;};
          flavor = lib.mkOption {
            type = lib.types.enum [
              "latte"
              "frappe"
              "macchiato"
              "mocha"
            ];
            default = "macchiato";
          };
          accent = lib.mkOption {
            type = lib.types.enum [
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
    catppuccin = lib.mkIf (cfg.enable && cfg.catppuccin.enable && isDesktop) {
      inherit (cfg.catppuccin) enable flavor accent;
    };
    home-manager = {
      users = {
        ${config.modules.users.user} = {
          imports = [inputs.catppuccin.homeManagerModules.catppuccin];
          catppuccin = lib.mkIf (cfg.enable && cfg.catppuccin.enable && isDesktop) {
            inherit (cfg.catppuccin) enable flavor accent;
          };
        };
      };
    };
  };
}
