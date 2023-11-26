{
  locale,
  lib,
  ...
}: let
  utfLocale = "${locale}_${lib.toUpper locale}.UTF-8";
in {
  i18n = {
    defaultLocale = utfLocale;
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
}
