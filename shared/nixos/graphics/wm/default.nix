{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./waybar
    #./wofi.nix
    ./mako.nix
    ./gammastep.nix
    #./ghostty.nix
    ./portal.nix

    ./fontconfig.nix
  ];
  services.copyq.enable = true;
  home.packages = lib.attrValues {
    inherit (pkgs)
      wl-clip-persist
      adwaita-icon-theme
      gnome-themes-extra
      imv
      ;
  };
}
