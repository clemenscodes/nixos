{ config, pkgs, user, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
    groups = {
      ${user} = {};
    };
    extraGroups = {
      docker = {
        members = [ "${user}" ];
      };
    };
    users = {
      ${user} = {
        isNormalUser = true; 
        description = "${user}"; 
	group = "${user}";
        extraGroups = [ "networkmanager" "wheel" ]; 
        shell = pkgs.zsh;
        hashedPasswordFile = config.sops.secrets.password.path;
      };
    };
  };
}
