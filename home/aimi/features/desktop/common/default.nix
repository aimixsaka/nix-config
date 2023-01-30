{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./firefox.nix
  ];

  xdg.mimeApps.enable = true;
}
