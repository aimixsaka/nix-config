{ lib, outputs, ... }:
{
  imports = [
    ./firefox.nix
    ./font.nix
    ./tmux.nix
    ./daily.nix
    ./tools.nix
  ];

  xdg.mimeApps.enable = true;
}
