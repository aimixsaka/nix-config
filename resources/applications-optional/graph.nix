{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    graphviz
    nix-du
    imv
  ];
}
