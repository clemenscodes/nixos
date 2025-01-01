{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.security;
  inherit (config.modules.users) user;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  options = {
    modules = {
      security = {
        sops = {
          enable = lib.mkEnableOption "Enable secrets using SOPS" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.sops.enable) {
    environment = {
      systemPackages = [
        (import ./setupsops.nix {inherit inputs pkgs lib;})
        pkgs.sops
        pkgs.age
        pkgs.ssh-to-age
      ];
    };
    sops = {
      age = {
        keyFile = "/home/${user}/.config/sops/age/keys.txt";
        sshKeyPaths = ["/home/${user}/.ssh/id_ed25519"];
      };
    };
  };
}
