{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
      ./calibre
      ./zathura
    ];
    options = {
      modules = {
        display = {
          pdfviewer = {
            enable = mkEnableOption "Enable PDF Viewer" // {default = cfg.enable;};
            defaultPdfViewer = mkOption {
              type = types.enum ["zathura"];
              default = "zathura";
            };
          };
        };
      };
    };
  }
