{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
  locale = config.modules.locale.defaultLocale;
  utfLocale = "${locale}_${lib.toUpper locale}.UTF-8";
in
  with lib; {
    options = {
      modules = {
        locale = {
          enable = mkEnableOption "Enable locale settings" // {default = cfg.enable;};
          defaultLocale = mkOption {
            type = types.str;
            default = "de";
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.locale.enable) {
      i18n = {
        defaultLocale = utfLocale;
        supportedLocales = ["all"];
        extraLocaleSettings = {
          LC_ADDRESS = utfLocale;
          LC_IDENTIFICATION = utfLocale;
          LC_MEASUREMENT = utfLocale;
          LC_MONETARY = utfLocale;
          LC_NAME = utfLocale;
          LC_NUMERIC = utfLocale;
          LC_PAPER = utfLocale;
          LC_TELEPHONE = utfLocale;
          LC_TIME = utfLocale;
        };
      };
    };
  }
