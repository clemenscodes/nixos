{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModule
  ];
  sops = {
    defaultSopsFile = ../../../../../secrets/secrets.yaml;
    age = {
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      sshKeyPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
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
      github_token = {
        path = "/run/user/1000/secrets/github_token";
      };
      gitlab_runner = {
        path = "/run/user/1000/secrets/gitlab_runner";
      };
    };
  };
}
