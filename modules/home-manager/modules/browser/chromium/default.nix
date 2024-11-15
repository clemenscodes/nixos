{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.browser;
in {
  options = {
    modules = {
      browser = {
        chromium = {
          enable = mkEnableOption "Enable chromium" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.chromium.enable) {
    programs = {
      chromium = {
        enable = cfg.chromium.enable;
        package = pkgs.brave;
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
        dictionaries = [
          pkgs.hunspellDictsChromium.de_DE
          pkgs.hunspellDictsChromium.en_US
        ];
        extensions = [
          {
            id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # ublock origin
          }
          {
            id = "nngceckbapebfimnlniiiahkandclblb"; # bitwarden
          }
          {
            id = "cmpdlhmnmjhihmcfnigoememnffkimlk"; # Catppuccin Chrome Theme - Macchiato
          }
          {
            id = "kmhcihpebfmpgmihbkipmjlmmioameka"; # Eternl
          }
          {
            id = "dbepggeogbaibhgnhhndojpepiihcmeb"; # Vimium
          }
        ];
      };
    };
  };
}
