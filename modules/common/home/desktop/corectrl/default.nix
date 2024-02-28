{...}: {
  xdg = {
    configFile = {
      "corectrl/corectrl.ini" = {
        text = ''
          [General]
          startOnSysTray=true
        '';
      };
    };
  };
}
