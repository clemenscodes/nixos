{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming;
in
  with lib; {
    options = {
      modules = {
        gaming = {
          steam = {
            enable = mkEnableOption "Enable steam" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.steam.enable) {
      environment = {
        systemPackages = with pkgs; [steamtinkerlaunch];
      };
      programs = {
        steam = {
          enable = cfg.steam.enable;
          steam.package = pkgs.steam.override {
            extraPkgs = pkgs:
              with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
              ];
          };
          gamescopeSession = {
            enable = cfg.gamescope.enable;
          };
          remotePlay = {
            openFirewall = true;
          };
          dedicatedServer = {
            openFirewall = true;
          };
          extest = {
            enable = true;
          };
          extraCompatPackages = with pkgs; [proton-ge-bin];
        };
      };
    };
  }
