{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.io;
  inherit (config.modules.users) user;
in
  with lib; {
    options = {
      modules = {
        io = {
          android = {
            enable = mkEnableOption "Enable android system service" // {default = false;};
          };
        };
      };
    };
    config = {
      programs = {
        adb = {
          inherit (cfg.android) enable;
        };
      };
      users = {
        users = {
          ${user} = {
            extraGroups = ["adbusers" "kvm"];
          };
        };
      };
      services = {
        udev = {
          packages = [pkgs.android-udev-rules];
        };
      };
    };
  }
