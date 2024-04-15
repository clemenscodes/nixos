{user, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];
  config = {
    home-manager = {
      users = {
        ${user} = {
          bat = {
            enable = true;
          };
        };
      };
    };
  };
}
