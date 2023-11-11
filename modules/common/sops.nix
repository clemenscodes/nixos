{ user, ... }: {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/${user}/.config/sops/age/keys.txt";
      sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
    };
    secrets = {
      password = {};
    };
  };
}

