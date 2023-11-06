{ user, ... }: {
  sops = {
    age = {
      sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
    };
    secrets = {};
  };
}
