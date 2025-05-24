{ inputs, ... }:
{
  imports = [
    inputs.apple-silicon.nixosModules.default

    ./configuration.nix
    ./user.nix
    ./filesystem.nix

    ../../shared/full-packages.nix
    ../../shared/nixos/graphics/wm/system.nix
    ../../shared/nixos/net.nix
  ];
}
