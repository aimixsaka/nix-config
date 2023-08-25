{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    steam
    wine 
    winetricks
    protontricks
    lutris
  ];
}
