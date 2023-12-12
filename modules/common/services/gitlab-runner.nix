{...}: {
  boot = {
    kernel = {
      sysctl = {
        "net.ipv4.ip_forward" = true;
      };
    };
  };
  virtualisation = {
    docker = {
      enable = true;
    };
  };
  services = {
    gitlab-runner = {
      enable = true;
      services = {
        default = {
          registrationConfigFile = "/run/user/1000/secrets/gitlab_runner";
          dockerImage = "ubuntu";
          description = "gitlab-runner";
          protected = true;
          tagList = [ "docker" ];
        };
      };
    };
  };
}
