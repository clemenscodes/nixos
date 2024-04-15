{
  inputs,
  user,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/wsl.nix
    inputs.wsl.nixosModules.default
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
