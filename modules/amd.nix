{pkgs, ...}: 
let
  driver = "amdgpu";
in
{
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
  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
        mesa
        mesa.opencl
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
        driversi686Linux.mesa
      ];
    };
  };
}
