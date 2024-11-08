{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with pkgs; let
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
          enable = mkEnableOption "Enable AMD GPU support" // {default = false;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.amd.enable) {
    modules = {
      gpu = {
        vendor = "amd";
      };
    };
    environment = {
      systemPackages = [
        clinfo
        rocmPackages.rocminfo
        glxinfo
        glmark2
        libva-utils
        (import ./gpu-usage-waybar {inherit pkgs;})
      ];
      variables = {
        OCL_ICD_VENDORS = "${rocm-opencl-icd}/etc/OpenCL/vendors/";
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
      "L+    /opt/rocm/hip   -    -    -     -    ${rocmPackages.clr}"
    ];
    hardware = {
      graphics = {
        enable = true;
        extraPackages = [
          amdvlk
          mesa
          mesa.drivers
          rocmPackages.clr
          rocmPackages.clr.icd
          rocmPackages.rocm-runtime
          rocm-opencl-runtime
        ];
        extraPackages32 = [
          driversi686Linux.amdvlk
          driversi686Linux.mesa
        ];
      };
    };
  };
}
