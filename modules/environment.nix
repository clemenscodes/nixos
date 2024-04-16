{
  pkgs,
  editor,
  browser,
  terminal,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      vim
    ];
    variables = {
      EDITOR = editor;
      BROWSER = browser;
      TERMINAL = terminal;
    };
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    localBinInPath = true;
    homeBinInPath = true;
    shells = with pkgs; [zsh];
  };
}
