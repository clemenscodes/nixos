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
      videoDrivers = ["amdgpu"];
    };
  };
  systemd = {
    tmpfiles = {
      rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
      ];
    };
  }; 
  environment = {
    variables = {
      ROC_ENABLE_PRE_VEGA = "1";
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
