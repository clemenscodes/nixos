{ config, pkgs, user, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
    groups = {
      ${user} = {};
    };
    users = {
      ${user} = {
        isNormalUser = true; 
        description = "${user}"; 
	group = "${user}";
        shell = pkgs.zsh;
        hashedPasswordFile = config.sops.secrets.password.path;
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
