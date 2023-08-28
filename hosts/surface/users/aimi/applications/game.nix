{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    steam
    wineWowPackages.staging
    winetricks
    protontricks
    lutris
  ];
}
