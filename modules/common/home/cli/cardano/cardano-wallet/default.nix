{
  inputs,
  system,
  ...
}: {
  home = {
    packages = with inputs.cardano-wallet.packages.${system}; [
      cardano-wallet
    ];
  };
}
