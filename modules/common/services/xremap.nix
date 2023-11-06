{ ... }: {
  services = {
    xremap = {
      withHypr = true;
      userName = "clay";
      yamlConfig = ''
        modmap:
          - name: "Better CapsLock"
            remap:
              CapsLock:
                held: SUPER_L
                alone: ESC
                alone_timeout_millis: 500
      '';
    };
  };
}
