{
  inputs,
  system,
  ...
}: {
  home = {
    packages = with inputs.aiken.packages.${system}; [
      aiken
    ];
  };
}
