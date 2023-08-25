{ 
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xwayland
  ];
}
