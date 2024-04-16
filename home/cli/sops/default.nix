{
  lib,
  config,
  osConfig,
  inputs,
  uid,
  ...
}:
with lib; let
  cfg = config.secrets;
in {
  imports = [
    inputs.sops-nix.homeManagerModule
  ];
  options = {
    secrets = {
      enable = mkEnableOption "Enable secrets using SOPS";
    };
  };
  config = mkIf (osConfig.secrets.enable && cfg.enable) {
    sops = {
      defaultSopsFile = ../../../secrets/secrets.yaml;
      age = {
        keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        generateKey = true;
        sshKeyPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
      };
      secrets = {
        "email/clemens.horn@mni.thm.de/password" = {
          path = "/run/user/${builtins.toString uid}/secrets/email/clemens.horn@mni.thm.de/password";
        };
        "email/horn_clemens@t-online.de/password" = {
          path = "/run/user/${builtins.toString uid}/secrets/email/horn_clemens@t-online.de/password";
        };
        "email/me@clemenshorn.com/password" = {
          path = "/run/user/${builtins.toString uid}/secrets/email/me@clemenshorn.com/password";
        };
        github_token = {
          path = "/run/user/${builtins.toString uid}/secrets/github_token";
        };
      };
    };
  };
}
