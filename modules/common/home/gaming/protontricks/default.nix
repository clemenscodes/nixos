{pkgs,...}: {
  environment = {
    systemPackages = with pkgs; [
      protontricks
    ];
  };
}
