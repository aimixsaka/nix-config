{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    steam
    wineWowPackages.staging
    #(wineWowPackages.staging.override {
    #  embedInstallers = true;
    #})
    winetricks
    protontricks
    lutris
  ];
}
