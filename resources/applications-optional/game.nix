{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    steam
    #wineWowPackages.staging
    #wineWowPackages.wayland
    wineWowPackages.waylandFull
    ## build failed
    #(wineWowPackages.staging.override { 
    #  waylandSupport = true;
    #  embedInstallers = true;
    #})
    winetricks
    protontricks
    lutris
    moonlight-qt
  ];
}
