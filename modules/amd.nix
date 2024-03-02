{pkgs, ...}: let
  driver = "amdgpu";
in
  with pkgs; {
    environment = {
      systemPackages = [clinfo rocmPackages.rocminfo];
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
      opengl = {
        enable = true;
        extraPackages = [
          amdvlk
          mesa
          mesa.drivers
          rocmPackages.clr
          rocmPackages.clr.icd
          rocmPackages.rocm-runtime
          rocm-opencl-icd
          rocm-opencl-runtime
        ];
        extraPackages32 = [
          driversi686Linux.amdvlk
          driversi686Linux.mesa
        ];
      };
    };
  }
