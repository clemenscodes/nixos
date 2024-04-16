{
  lib,
  config,
  user,
  inputs,
  ...
}:
with lib; let
  cfg = config.secrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  options = {
    secrets = {
      enable = mkEnableOption "Enable secrets using SOPS";
    };
  };
  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      age = {
        keyFile = "/home/${user}/.config/sops/age/keys.txt";
        generateKey = true;
        sshKeyPaths = ["/home/${user}/.ssh/id_ed25519"];
      };
      secrets = {
        password = {
          neededForUsers = true;
        };
        wifi = {
          neededForUsers = true;
        };
        nix_access_tokens = {};
      };
    };
  };
}
