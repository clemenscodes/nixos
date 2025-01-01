{
  inputs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [inputs.disko.nixosModules.default];
  options = {
    modules = {
      disk = {
        enable = lib.mkEnableOption "Enable disk configuration" // {default = false;};
        device = lib.mkOption {
          type = lib.types.str;
          description = "The device to install the filesystem on using disko";
          example = "/dev/sdc";
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.disk.enable) {
    disko = {
      devices = {
        disk = {
          main = {
            device = lib.mkDefault cfg.disk.device;
            type = "disk";
            content = {
              type = "gpt";
              efiGptPartitionFirst = false;
              partitions = {
                bios = {
                  priority = 1;
                  type = "EF02";
                  size = "1M";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = null;
                  };
                  hybrid = {
                    mbrPartitionType = "0x0c";
                    mbrBootableFlag = false;
                  };
                };
                efi = {
                  priority = 2;
                  type = "EF00";
                  size = "512M";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = ["umask=0077"];
                  };
                };
                luks = {
                  priority = 5;
                  size = "100%";
                  content = {
                    type = "luks";
                    name = "root";
                    askPassword = true;
                    settings = {
                      allowDiscards = false;
                    };
                    content = {
                      type = "lvm_pv";
                      vg = "pool";
                    };
                  };
                };
              };
            };
            lvm_vg = {
              pool = {
                type = "lvm_vg";
                lvs = {
                  root = {
                    size = "100%FREE";
                    content = {
                      type = "btrfs";
                      extraArgs = ["-f"];

                      subvolumes = {
                        "/root" = {
                          mountpoint = "/";
                        };

                        "/persist" = {
                          mountOptions = ["subvol=persist" "noatime"];
                          mountpoint = "/persist";
                        };

                        "/nix" = {
                          mountOptions = ["subvol=nix" "noatime"];
                          mountpoint = "/nix";
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
