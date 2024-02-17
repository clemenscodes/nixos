{pkgs, ...}: let
  driver = "amdgpu";
in {
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
        mesa
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
        driversi686Linux.mesa
      ];
    };
  };
}
