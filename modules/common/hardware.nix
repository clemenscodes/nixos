{ config, ... }: {
  hardware = {
    pulseaudio = {
      enable = false;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
