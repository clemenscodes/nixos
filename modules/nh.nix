{
  lib,
  config,
  pkgs,
  user,
  ...
}:
with lib; let
  cfg = config.nh;
in {
  options = {
    nh = {
      enable = mkEnableOption "Enable yet another nix cli helper" // {default = true;};
    };
  };
  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [nh];
      sessionVariables = {
        FLAKE = "/home/${user}/.config/nixos";
      };
    };
  };
}
