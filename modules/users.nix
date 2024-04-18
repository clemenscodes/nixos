{
  lib,
  config,
  pkgs,
  user,
  ...
}:
with lib; {
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    groups = {
      ${user} = {};
    };
    users = {
      ${user} = {
        isNormalUser = true;
        description = user;
        group = user;
        shell = pkgs.zsh;
        hashedPasswordFile = mkIf config.secrets.enable config.sops.secrets.password.path;
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "kvm"
          "docker"
        ];
      };
    };
  };
}
