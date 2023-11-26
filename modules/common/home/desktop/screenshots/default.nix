{
  pkgs,
  user,
  ...
}: {
  home = {
    packages = with pkgs; [
      grim
      slurp
      swappy
    ];
  };
  xdg = {
    configFile = {
      "swappy/config" = {
        text = ''
          [Default]
          save_dir=/home/${user}/.local/share/images/screenshots
        '';
      };
    };
  };
}
