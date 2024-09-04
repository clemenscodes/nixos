{inputs}: {
  lib,
  config,
  osConfig,
  ...
}:
with lib; let
  cfg = config.modules.security;
in {
  imports = [
    inputs.sops-nix.homeManagerModule
  ];
  options = {
    modules = {
      security = {
        sops = {
          enable = mkEnableOption "Enable secrets using SOPS" // {default = false;};
        };
      };
    };
  };
  config = mkIf (osConfig.modules.security.sops.enable && cfg.enable && cfg.sops.enable) {
    sops = {
      age = {
        keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        generateKey = true;
        sshKeyPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
      };
    };
  };
}
