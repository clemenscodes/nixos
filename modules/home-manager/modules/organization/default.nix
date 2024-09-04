{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./calcurse
      ./email
      ./libreoffice
      ./zotero
    ];
    options = {
      modules = {
        organization = {
          enable = mkEnableOption "Enable tools for organization" // {default = cfg.enable;};
        };
      };
    };
  }
