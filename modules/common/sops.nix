{
  user,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
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
}
