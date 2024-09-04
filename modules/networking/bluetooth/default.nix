{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking;
  bluez = "${import ./bluez {inherit pkgs lib;}}";
in
  with lib; {
    options = {
      modules = {
        networking = {
          bluetooth = {
            enable = mkEnableOption "Enable bluetooth" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.bluetooth.enable) {
      environment = {
        systemPackages = with pkgs; [
          python311Packages.ds4drv
        ];
      };
      boot = {
        kernelParams = [
          "btusb.enable_autosuspend=n"
        ];
      };
      hardware = {
        bluetooth = {
          enable = cfg.bluetooth.enable;
          powerOnBoot = true;
          package = bluez;
          input = {
            General = {
              UserspaceHID = true;
            };
          };
          settings = {
            General = {
              ControllerMode = "bredr";
              FastConnectable = true;
              Enable = "Source,Sink,Media,Socket";
            };
          };
        };
      };
      services = {
        blueman = {
          enable = cfg.bluetooth.enable;
        };
        udev = {
          packages = [
            (pkgs.writeTextFile {
              name = "dualshock_4";
              text = ''
                KERNEL=="uinput", MODE="0666"
                KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
                KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:05C4.*", MODE="0666"
                KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"
                KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:09CC.*", MODE="0666"
                # Valve HID devices over bluetooth hidraw
                KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
                # Dualshock 4 over bluetooth hidraw
                KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0666"
                # Dualshock 4 Slim over bluetooth hidraw
                KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0666"
              '';
              destination = "/etc/udev/rules.d/99-ds4-controller.rules";
            })
          ];
        };
      };
    };
  }
