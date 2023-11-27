{pkgs,...}: 
let
  bluez = (import (builtins.fetchTarball {




    url = "https://github.com/NixOS/nixpkgs/archive/0ffaecb6f04404db2c739beb167a5942993cfd87.tar.gz";
    sha256 = "1cpz6c9k8limrd84sp7rayn8ghv5v0pym8gjhg4vz9bdc9ikh4az";
  }) {inherit (pkgs) system;}).bluez;
in
{
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
