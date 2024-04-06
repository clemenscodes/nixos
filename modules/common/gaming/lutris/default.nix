{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      (lutris.override {
        extraLibraries = pkgs: [];
        extraPkgs = pkgs: [];
      })
    ];
  };
}
