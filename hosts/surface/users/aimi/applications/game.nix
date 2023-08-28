{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    steam
    #wine 
    wine-staging
    winetricks
    protontricks
    lutris
  ];
}
