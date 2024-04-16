{
  pkgs,
  user,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [tpm2-tools];
  };

  security = {
    tpm2 = {
      enable = true;
      pkcs11 = {
        enable = true;
      };
      tctiEnvironment = {
        enable = true;
      };
    };
  };
  users = {
    users = {
      "${user}" = {
        extraGroups = ["tss"];
      };
    };
  };
}
