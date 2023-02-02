{ pkgs, inputs, ... }:
{
  imports = [
    ./alacritty.nix
    ./mako.nix
    ./waybar.nix
    ./wofi.nix
    ./tools.nix
  ];

  #home.packages = with pkgs; [
  #];
}
