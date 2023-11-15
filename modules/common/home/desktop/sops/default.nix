{ inputs, user, ... }: {
  imports = [
    inputs.sops-nix.homeManagerModule
  ];
  sops = {
    defaultSopsFile = ../../../../../secrets/secrets.yaml;
    age = {
      keyFile = "/home/${user}/.config/sops/age/keys.txt";
      sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
    };
    secrets = {
      "email/uni/password" = {};
      "email/private/password" = {};
      "email/business/password" = {};
    };
  };
}
