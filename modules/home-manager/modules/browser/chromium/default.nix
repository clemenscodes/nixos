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
            id = "lnjaiaapbakfhlbjenjkhffcdpoompki"; # Catppuccin GitHub File Explorer Icons
          }
          {
            id = "hlepfoohegkhhmjieoechaddaejaokhf"; # Refined GitHub
          }
          {
            id = "kmhcihpebfmpgmihbkipmjlmmioameka"; # Eternl
          }
          {
            id = "dbepggeogbaibhgnhhndojpepiihcmeb"; # Vimium
          }
          {
            id = "khncfooichmfjbepaaaebmommgaepoid"; # Remove YouTube Shorts / Recommended
          }
          {
            id = "gebbhagfogifgggkldgodflihgfeippi"; # YouTube Dislikes
          }
          {
            id = "edibdbjcniadpccecjdfdjjppcpchdlm"; # I still don't care about cookies
          }
          {
            id = "bmnlcjabgnpnenekpadlanbbkooimhnj"; # Honey - get coupons
          }
          {
            id = "cofdbpoegempjloogbagkncekinflcnj"; # DeepL - Translations
          }
        ];
      };
    };
  };
}
