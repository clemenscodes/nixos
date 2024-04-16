{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.bat;
in {
  options = {
    bat = {
      enable = mkEnableOption "Enables bat";
    };
  };
  config = mkIf cfg.enable {
    programs = {
      bat = {
        enable = true;
      };
    };
  };
}
