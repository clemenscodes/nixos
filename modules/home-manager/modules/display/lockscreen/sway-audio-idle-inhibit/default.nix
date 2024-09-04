{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display.lockscreen;
  swayAudioIdleInhibit = pkgs.stdenv.mkDerivation {
    name = "sway-audio-idle-inhibit";

    buildInputs = with pkgs; [
      cmake
      pkg-config
      wayland-protocols
      libpulseaudio
      wayland
      ninja
    ];

    shellHook = ''
      export PKG_CONFIG_PATH="${pkgs.pkg-config}/lib/pkgconfig"
    '';

    dontUseCmakeConfigure = true;

    out = "out";

    src = pkgs.fetchFromGitHub {
      owner = "ErikReider";
      repo = "SwayAudioIdleInhibit";
      rev = "c850bc4812216d03e05083c69aa05326a7fab9c7";
      sha256 = "02z2nmqhiggvpx66lw9gx7nk5bdc8p2szc37a5zy5ljqkhbz5b1h";
    };

    configurePhase = ''
      ${pkgs.meson}/bin/meson build
    '';

    buildPhase = ''
      ${pkgs.ninja}/bin/ninja -C build
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp ./build/sway-audio-idle-inhibit $out/bin
    '';
  };
in
  with lib; {
    options = {
      modules = {
        display = {
          lockscreen = {
            sway-audio-idle-inhibit = {
              enable = mkEnableOption "Enable sway-audio-idle-inhibit" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.sway-audio-idle-inhibit.enable) {
      home = {
        packages = [swayAudioIdleInhibit];
      };
    };
  }
