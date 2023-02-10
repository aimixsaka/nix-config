# This file (and the global directory) holds config that i use on all hosts
{ lib, inputs, outputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./sound.nix
    ./nix.nix
    ./steam-hardware.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    ## Overlay to use myself packages instead
    overlays = builtins.attrValues outputs.overlays;
    config = {
      #allowUnfreePredicate = 
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam-original"
      ];
    };
  };

  environment = {
    persistence = {
      "/persist".directories = [ "/var/lib/systemd" "/var/log" "/srv" ];
    };
    enableAllTerminfo = true;
  };
}
