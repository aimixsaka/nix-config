{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./waybar
    ./wofi.nix
    ./mako.nix
    ./gammastep.nix
    ./ghostty.nix
    ./portal.nix

    ./fontconfig.nix
  ];
  home.packages = lib.attrValues {
    inherit (pkgs)
      qbittorrent
      ;
  };
}
