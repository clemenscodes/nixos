{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.gpu;
  driver = "amdgpu";
in {
  imports = [
    ./corectrl
    ./lact
  ];
  options = {
    modules = {
      gpu = {
        amd = {
          enable = lib.mkEnableOption "Enable AMD GPU support" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.amd.enable) {
    modules = {
      gpu = {
        vendor = "amd";
      };
    };
    environment = {
      systemPackages = [
        pkgs.clinfo
        pkgs.glxinfo
        pkgs.glmark2
        pkgs.libva-utils
        pkgs.vulkan-tools
        (import ./gpu-usage-waybar {inherit pkgs;})
      ];
      variables = {
        # OCL_ICD_VENDORS = "${rocmPackages.clr.icd}/etc/OpenCL/vendors/";
      };
    };
    boot = {
      initrd = {
        kernelModules = [driver];
      };
      kernelModules = [driver];
    };
    services = {
      xserver = {
        enable = true;
        videoDrivers = [driver];
      };
    };
    systemd.tmpfiles.rules = [
      # "L+    /opt/rocm/hip   -    -    -     -    ${rocmPackages.clr}"
    ];
    hardware = {
      graphics = {
        enable = true;
        extraPackages = [
          pkgs.amdvlk
          pkgs.mesa
          pkgs.mesa.drivers
          # rocmPackages.clr
          # rocmPackages.clr.icd
          # rocmPackages.rocm-runtime
        ];
        extraPackages32 = [
          pkgs.driversi686Linux.amdvlk
          pkgs.driversi686Linux.mesa
        ];
      };
    };
  };
}
