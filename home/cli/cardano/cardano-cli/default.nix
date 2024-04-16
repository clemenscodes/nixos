{
  inputs,
  system,
  ...
}: {
  home = {
    packages = with inputs.cardano-cli.legacyPackages.${system}; [
      cardano-cli
    ];
  };
}
