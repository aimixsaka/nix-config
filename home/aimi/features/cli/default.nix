{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./tools.nix
    ./pls.nix
  ];

  # home.packages = with pkgs; [
  # ]
}
