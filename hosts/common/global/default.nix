# This file (and the global directory) holds config that i use on all hosts
{ inputs, outputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./sound.nix
    ./shells.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  environment = {
    persistence = {
      "/persist".directories = [ "/var/lib/systemd" "/var/log" "/srv" ];
    };
    enableAllTerminfo = true;
  };
}
