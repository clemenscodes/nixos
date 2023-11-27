{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      (lutris.override {
        extraLibraries = pkgs: [];
        extraPkgs = pkgs: [
    		  wineWowPackages.stable
    		  winetricks
        ];
      })
    ];
  };
}
