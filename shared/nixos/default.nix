{ inputs, ... }:
{
  imports = [
    inputs.nixos-facter-modules.nixosModules.facter
    inputs.disko.nixosModules.disko
    ../common.nix
    ./env.nix
  ];
}
