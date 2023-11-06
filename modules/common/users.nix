{ pkgs, user, ... }: {
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
        extraGroups = [ "networkmanager" "wheel" ]; 
        shell = pkgs.zsh;
      };
    };
  };
}
