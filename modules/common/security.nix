{ user, ... }: {
  security = {
    rtkit = {
      enable = true;
    };
    pam = {
      services = {
        swaylock = {};
        "${user}" = {
          gnupg = {
            enable = true;
          };
        };
      };
    };
  };
}
