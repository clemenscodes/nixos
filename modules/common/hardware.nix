{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      glxinfo
      glmark2
    ];
  };
  hardware = {
    pulseaudio = {
      enable = false;
    };
    ledger = {
      enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        mesa.drivers
      ];
      extraPackages32 = [];
    };
  };
}
