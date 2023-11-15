{ pkgs, ... }: {
  environment.systemPackages = [
    (import ./setupsops { inherit pkgs; })
  ];
}
