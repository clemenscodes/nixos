{inputs}: {
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development;
in
  with lib; {
    imports = [inputs.android-nixpkgs.hmModule];
    options = {
      modules = {
        development = {
          android = {
            enable = mkEnableOption "Enable android development support" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.android.enable) {
      android-sdk = {
        inherit (cfg.android) enable;
        packages = sdk:
          with sdk; [
            platform-tools
            emulator
            cmdline-tools-latest
            ndk-27-2-12479018
            build-tools-35-0-0
            platforms-android-35
            sources-android-35
          ];
      };
    };
  }
