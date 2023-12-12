{pkgs, ...}: {
  boot = {
    initrd = {
      kernelModules = ["amdgpu"];
    };
    kernelModules = ["amdgpu"];
  };
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu" ];
    };
  };
  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
        mesa
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
