{ inputs, ... }:

{
  imports = [
    inputs.nixos-facter-modules.nixosModules.facter
    ../common.nix
    ./net.nix
  ];
}
