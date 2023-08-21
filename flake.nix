{
  description = "aimixsaka's nixos config";

  outputs = { 
    self, 
    nixpkgs-stable, 
    nixpkgs,
    home-manager, 
    nixos-generators,
    ... 
  }@inputs:

  let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    pkgsFor = nixpkgs.legacyPackages;
  in
  {
    inherit lib;

    #nixosModules = import ./modules/nixos;
    nixosModules.all = {config, ...}: {
      imports = [
        nixos-generators.nixosModules.all-formats
      ];

      nixpkgs.hostPlatform = "x86_64-linux";
    };

    homeManagerModules = import ./modules/home-manager;
    #templates = import ./templates;
    #overlays = import ./overlays { inherit inputs outputs; };
    #packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
    #devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; }

    nixosConfigurations = {
      surface = lib.nixosSystem {

        modules = [
          ./hosts/surface 

          # useful for all hosts
          self.nixosModules.all
        ];

	      specialArgs = { inherit inputs outputs; };
      };
    };

    homeConfigurations = {
      "aimi@surface" = lib.homeManagerConfiguration {
        modules = [ ./hosts/surface/users/aimi ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };


  # the nixConfig affects the flake itself,
  # not the system configuration
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    # nixpkgs
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-23.05";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      # nixpkgs in home-manager flake inputs follows our nixpkgs above
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/main";
    };

    hardware.url = "github:nixos/nixos-hardware";

    # For persistence
    impermanence.url = "github:nix-community/impermanence";

    # generate iso ...
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}
