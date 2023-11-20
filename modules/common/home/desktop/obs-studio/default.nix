{ config, pkgs, ... }: {
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        input-overlay
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}
