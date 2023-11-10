{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [ 
      vim
    ];
    variables = {
      EDITOR = "nvim";
      BROWSER = "brave";
      TERMINAL = "kitty";
    };
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    shells = with pkgs; [ zsh ];
  };
}
