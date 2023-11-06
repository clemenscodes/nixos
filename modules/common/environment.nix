{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [ 
      vim
      file
      home-manager
    ];
    variables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERMINAL = "kitty";
    };
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    shells = with pkgs; [ zsh ];
  };
}
