{inputs}: {
  system,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules;
  user = cfg.users.user;
  isDesktop = cfg.display.gui != "headless";
in {
  imports = [
    ./docker
    ./virt-manager
  ];
  options = {
    modules = {
      virtualisation = {
        enable = mkEnableOption "Enable virtualisation" // {default = false;};
      };
    };
  };
  config = mkIf (cfg.enable && cfg.virtualisation.enable) {
    virtualisation = {
      libvirtd = {
        inherit (cfg.virtualisation) enable;
        qemu = {
          package = pkgs.qemu_kvm;
          vhostUserPackages = [pkgs.virtiofsd];
          swtpm = {
            inherit (cfg.virtualisation) enable;
          };
        };
      };
      spiceUSBRedirection = {
        inherit (cfg.virtualisation) enable;
      };
    };
    services = {
      spice-vdagentd = {
        inherit (cfg.virtualisation) enable;
      };
      spice-webdavd = {
        inherit (cfg.virtualisation) enable;
      };
      qemuGuest = {
        inherit (cfg.virtualisation) enable;
      };
    };
    home-manager = mkIf (cfg.home-manager.enable && isDesktop) {
      users = {
        ${user} = {
          dconf = {
            settings = {
              "org/virt-manager/virt-manager/connections" = {
                autoconnect = ["qemu:///system"];
                uris = ["qemu:///system"];
              };
            };
          };
        };
      };
    };
  };
}
