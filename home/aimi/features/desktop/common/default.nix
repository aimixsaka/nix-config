{ lib, outputs, ... }:
{
  imports = [
    ./firefox.nix
    ./font.nix
    ./tmux.nix
  ];

  xdg.mimeApps.enable = true;
}
