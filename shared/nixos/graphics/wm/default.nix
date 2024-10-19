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
    ./alacritty.nix
    ./portal.nix

    ./fontconfig.nix
    ./vnc.nix
  ];
  home.packages = lib.attrValues {
    inherit (pkgs)
      wayvnc
      tigervnc
      ;
  };
}
