{user, ...}: {
  imports = [./hardware-configuration.nix];
  config = {
    modules = {
      enable = true;
    };
    secrets = {
      enable = false;
    };
    gpu = {
      enable = false;
      amd = {
        enable = false;
      };
    };
    secureboot = {
      enable = false;
    };
    home-manager = {
      users = {
        ${user} = {
          imports = [../../home/desktop];
          modules = {
            home = {
              enable = true;
            };
          };
          bat = {
            enable = true;
          };
          secrets = {
            enable = false;
          };
          email = {
            enable = false;
          };
        };
      };
    };
  };
}
