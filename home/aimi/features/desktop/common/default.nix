{ lib, outputs, ... }:
{
  imports = [
    ./firefox.nix
    ./font.nix
    ./tmux.nix
    ./daily.nix
  ];

  xdg.mimeApps.enable = true;
}
