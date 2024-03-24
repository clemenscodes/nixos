{
  inputs,
  system,
  ...
}: {
  home = {
    packages = with inputs.cardano-node.packages.${system}; [
      cardano-node
    ];
  };
}
