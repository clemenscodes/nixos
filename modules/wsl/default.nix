{inputs}: {
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules;
  inherit (config.modules.users) name;
in {
  imports = [inputs.wsl.nixosModules.default];
  options = {
    modules = {
      wsl = {
        enable = mkEnableOption "Enable WSL support" // {default = cfg.machine.kind == "wsl";};
      };
    };
  };
  config = mkIf (cfg.enable && cfg.wsl.enable) {
    users.users.${name} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
      ];
    };
    wsl = {
      enable = true;
      defaultUser = cfg.users.user;
      interop = {
        includePath = true;
        register = true;
      };
      docker-desktop = {
        enable = false;
      };
      extraBin = with pkgs; [
        {src = "${coreutils}/bin/mkdir";}
        {src = "${coreutils}/bin/cat";}
        {src = "${coreutils}/bin/whoami";}
        {src = "${coreutils}/bin/ls";}
        {src = "${busybox}/bin/addgroup";}
        {src = "${su}/bin/groupadd";}
        {src = "${su}/bin/usermod";}
      ];
      # NOTE: If systemd user units do not work,
      # follow the instructions here https://github.com/nix-community/NixOS-WSL/issues/527#issuecomment-2271417039
      nativeSystemd = true;
      startMenuLaunchers = true;
      usbip = {
        enable = true;
        autoAttach = [];
      };
      useWindowsDriver = true;
      wslConf = {
        automount = {
          enabled = true;
          mountFsTab = false;
          options = "metadata,uid=1000,gid=100";
          root = "/mnt";
        };
        interop = {
          enabled = true;
          appendWindowsPath = true;
        };
        network = {
          generateHosts = true;
          generateResolvConf = true;
          hostname = config.networking.hostName;
        };
        user = {
          default = cfg.users.user;
        };
      };
    };
    environment = {
      shellAliases = {
        docker = "/run/current-system/sw/bin/docker";
      };
    };
    virtualisation = {
      docker = {
        enable = true;
        enableOnBoot = true;
        autoPrune = {
          enable = true;
        };
      };
    };
    environment = {
      systemPackages = with pkgs; [
        wslu
        wsl-open
        wsl-vpnkit
      ];
    };
    systemd = {
      services = {
        docker-desktop-proxy = let
          root = config.wsl.wslConf.automount.root;
        in {
          script = lib.mkForce ''
            ${root}/wsl/docker-desktop/docker-desktop-user-distro proxy \
              --docker-desktop-root ${root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"
          '';
        };
        wsl-vpnkit-auto = {
          enable = true;
          description = "wsl-vpnkit";
          path = [pkgs.iputils];
          script = ''
            has_internet () {
              ping -q -w 1 -c 1 8.8.8.8 >/dev/null
            }

            is_active_wsl-vpnkit () {
              systemctl is-active -q wsl-vpnkit.service
            }

            main () {
              if ! has_internet; then
                echo "Starting wsl-vpnkit..."
                systemctl start wsl-vpnkit.service
              fi
            }

            while :
            do
              main
              sleep 5
            done
          '';
          wantedBy = ["multi-user.target"];
        };
        wsl-vpnkit = {
          enable = true;
          description = "wsl-vpnkit";
          serviceConfig = {
            ExecStart = "${pkgs.wsl-vpnkit}/bin/wsl-vpnkit";
            Type = "idle";
            Restart = "always";
            KillMode = "mixed";
          };
        };
      };
    };
  };
}
