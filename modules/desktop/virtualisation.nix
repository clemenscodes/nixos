{pkgs, ...}: {
  programs = {
    virt-manager = {
      enable = true;
    };
  };
  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu = {
        ovmf = {
          enable = true;
        };
        swtpm = {
          enable = true;
        };
        verbatimConfig = ''
          bridge_helper = "${pkgs.qemu}/libexec/qemu-bridge-helper"
        '';
      };
    };
    spiceUSBRedirection = {
      enable = true;
    };
  };
}
