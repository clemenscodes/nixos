{
  pkgs,
  lib,
  ...
}: let
  bluez = "${import ./bluez {inherit pkgs lib;}}";
in {
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
      enable = true;
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
      enable = true;
    };
  };
}
