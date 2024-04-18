{user, ...}: {
  imports = [./hardware-configuration.nix];
  config = {
    modules = {
      enable = true;
    };
    windows = {
      enable = true;
    };
    home-manager = {
      users = {
        ${user} = {
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
