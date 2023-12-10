{
  config,
  pkgs,
  ...
}: {
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
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        mesa.drivers
        mangohud
      ];
      extraPackages32 = with pkgs; [
        mangohud
      ];
    };
  };
}
