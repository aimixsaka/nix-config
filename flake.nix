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
    systems = [ "x86_64-linux" "riscv64-linux" ];
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        #config.allowUnfree = true;
    });
  in
  {
    inherit lib;

    homeManagerModules = import ./modules/home-manager;

    # can resumed by nix build 
    # used in ./resources/system/nixpkgs.nix
    overlays = import ./overlays { inherit inputs outputs; };

    # nixos generators(to generate iso...)
    # deeply merge two attr sets
    packages = lib.recursiveUpdate (forEachSystem (pkgs: import ./pkgs { inherit pkgs; })) {
      "x86_64-linux" = import ./pkgs/iso.nix {
        pkgs = nixpkgs-stable.legacyPackages.x86_64-linux;
        lib = nixpkgs-stable.legacyPackages.x86_64-linux.lib;
        system = "x86_64-linux";
	inherit nixos-generators;
      };
    };

    nixosConfigurations = {
      surface = lib.nixosSystem rec {
        modules = [ ./hosts/surface ];

	specialArgs = {
	  inherit inputs outputs; 
	  pkgs-stable = import nixpkgs-stable {
	    system = "x86_64-linux";
	    #config.allowUnfree = true;
	  };
	};
      };
    };

    homeConfigurations = {
      "aimi@surface" = lib.homeManagerConfiguration rec {
        modules = [ ./hosts/surface/users/aimi ];

        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
	  inherit inputs outputs; 
	  pkgs-stable = import nixpkgs-stable {
	    system = "x86_64-linux";
	    #config.allowUnfree = true;
	  };
	};
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
      url = "github:nix-community/home-manager";
      # nixpkgs in home-manager flake inputs follows our nixpkgs above
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/main";
    };

    hardware.url = "github:nixos/nixos-hardware";

    # my nixos-hardware fork
    hardware-self.url = "github:aimixsaka/nixos-hardware";

    # For persistence
    impermanence.url = "github:nix-community/impermanence";

    # generate iso ...
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    ## personal repo
  };

}
