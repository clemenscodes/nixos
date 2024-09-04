{inputs}: {
  lib,
  config,
  ...
}: let
  cfg = config.modules.io;
in
  with lib; {
    imports = [inputs.xremap-flake.nixosModules.default];
    options = {
      modules = {
        io = {
          xremap = {
            enable = mkEnableOption "Enable xremap system service" // {default = cfg.enable;};
          };
        };
      };
    };
    config = {
      services = {
        xremap = {
          enable = cfg.enable && cfg.xremap.enable && config.modules.display.gui != "headless";
          withWlroots = config.modules.display.gui == "wayland";
          userName = config.modules.users.user;
          watch = true;
          yamlConfig = ''
            modmap:
              - name: "Better CapsLock"
                remap:
                  CapsLock:
                    held: SUPER_L
                    alone: ESC
                    alone_timeout_millis: 500
          '';
        };
      };
    };
  }
