{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./font.nix
    ./firefox.nix
  ];

  xdg.mimeApps.enable = true;
}
