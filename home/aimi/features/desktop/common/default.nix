{ lib, outputs, ... }:
{
  imports = [
    ./firefox.nix
    ./font.nix
    ./tmux.nix
    ./daily.nix
    ./tools.nix
    ./icon.nix
    ./mpv.nix
  ];

  xdg.mimeApps.enable = true;
}
