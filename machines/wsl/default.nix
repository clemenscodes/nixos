{user, ...}: {
  imports = [./hardware-configuration.nix];
  config = {
    home-manager = {
      users = {
        ${user} = {
          email = {
            enable = true;
          };
          bat = {
            enable = true;
          };
        };
      };
    };
    windows = {
      enable = true;
    };
    secrets = {
      enable = true;
    };
  };
}
