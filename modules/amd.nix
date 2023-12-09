{pkgs, ...}: {
  boot = {
    initrd = {
      kernelModules = ["amdgpu"];
    };
  };
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu" ];
    };
  };
}
