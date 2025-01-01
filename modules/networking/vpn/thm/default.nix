{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.networking.vpn;
  thmvpn = pkgs.writeShellScriptBin "thmvpn" ''
    PROTOCOL="anyconnect"
    SERVER="vpn.thm.de"
    USERNAME="''${1:-$(${pkgs.bat}/bin/bat ${cfg.thm.usernameFile} --style=plain)}"
    PASSWORD="''${2:-$(${pkgs.bat}/bin/bat ${cfg.thm.passwordFile} --style=plain)}"
    echo "$PASSWORD" | sudo ${pkgs.openconnect}/bin/openconnect --protocol=$PROTOCOL --server=$SERVER --user=$USERNAME --passwd-on-stdin
  '';
in {
  options = {
    modules = {
      networking = {
        vpn = {
          thm = {
            enable = lib.mkEnableOption "Enable THM VPN using openconnect" // {default = false;};
            usernameFile = lib.mkOption {
              type = lib.types.path;
            };
            passwordFile = lib.mkOption {
              type = lib.types.path;
            };
          };
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.thm.enable) {
    environment = {
      systemPackages = [thmvpn];
    };
  };
}
