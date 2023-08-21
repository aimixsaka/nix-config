{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # network
    xray
    v2raya
  ];
}
