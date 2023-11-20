{ ... }: {
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
      qemu = {
        ovmf = {
          enable = true;
        };
        swtpm = {
          enable = true;
        };
      };
    };
    spiceUSBRedirection = {
      enable = true;
    };
  };
}
