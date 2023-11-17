{ pkgs, ... }: 
let
  hibernateEnvironment = {
    HIBERNATE_SECONDS = "3600";
    HIBERNATE_LOCK = "/var/run/autohibernate.lock";
  };
in {
  services = {
    acpid = {
      enable = true;
    };
  };
  powerManagement = {
    enable = true;
  };
}
