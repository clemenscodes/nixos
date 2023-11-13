{ user, ... }: {
  security = {
    rtkit = {
      enable = true;
    };
    pam = {
      services = {
        "${user}" = {
          gnupg = {
            enable = true;
          };
        };
      };
    };
  };
}
