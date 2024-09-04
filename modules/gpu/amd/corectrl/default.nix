{
  config,
  lib,
  ...
}: let
  cfg = config.modules.gpu.amd;
  isDesktop = config.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        gpu = {
          amd = {
            corectrl = {
              enable = mkEnableOption "Enable corectrl for AMD GPUs" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.corectrl.enable) {
      programs = {
        corectrl = {
          enable = cfg.corectrl.enable;
          gpuOverclock = {
            enable = true;
            ppfeaturemask = "0xfff7ffff";
          };
        };
      };
      security = {
        polkit = {
          enable = true;
          extraConfig =
            /*
            javascript
            */
            ''
              polkit.addRule(function(action, subject) {
                const isInit = action.id == "org.corectrl.helper.init" || action.id == "org.corectrl.helperkiller.init";
                const isLocal = subject.local == true;
                const isActive = subject.active == true;
                const hasUserGroup = subject.isInGroup("${config.modules.users.user}");
                if (isInit && isLocal && isActive && hasUserGroup) {
                  return polkit.Result.YES;
                }
              });
            '';
        };
      };
      home-manager = mkIf (config.modules.home-manager.enable && isDesktop) {
        users = {
          ${config.modules.users.user} = {
            xdg = {
              configFile = {
                "corectrl/corectrl.ini" = {
                  text = ''
                    [General]
                    startOnSysTray=true
                  '';
                };
              };
            };
          };
        };
      };
    };
  }
