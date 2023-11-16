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
      "email/clemens.horn@mni.thm.de/password" = {
        path = "/run/user/1000/secrets/email/clemens.horn@mni.thm.de/password";
      };
      "email/horn_clemens@t-online.de/password" = {
        path = "/run/user/1000/secrets/email/horn_clemens@t-online.de/password";
      };
      "email/me@clemenshorn.com/password" = {
        path = "/run/user/1000/secrets/email/me@clemenshorn.com/password";
      };
    };
  };
}
