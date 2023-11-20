{ pkgs, ... }: {
  programs = {
    virt-manager = {
      enable = true;
    };
  };
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu = {
        ovmf = {
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
