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
      extraPackages = with pkgs; [];
      extraPackages32 = with pkgs; [];
    };
  };
}
