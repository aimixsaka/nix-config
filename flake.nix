{
  description = "nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For persistence
    impermanence.url = "github:nix-community/impermanence";
   
  
    # TODO: use NUR
    # NUR
    #nur.url = github:nix-community/NUR; 

    # Nixified software I use
    hyprland = {
      url = "github:hyprwm/Hyprland/main";
    };
    # TODO: use NUR instead
    # Every day updated firefox addons(extentions)
    # Not that useful when you have firefox account synced
    #firefox-addons = {
    #  url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    # TODO: Add any other flake you might need
    hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let 
      inherit (nixpkgs.lib) filterAttrs;
      inherit (self) outputs;
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
      ## HM modules
      homeManagerModules = import ./modules/home-manager;

      ## Packages
      packages = forAllSystems (system:
        import ./pkgs { pkgs = nixpkgs.legacyPackages.${system}; }
      );

      overlays = import ./overlays; 

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = rec {
        # FIXME replace with your hostname
        taiga = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
          # > Our main nixos configuration file <
          modules = [ ./hosts/taiga ];
          # TODO: if you want to use NUR, uncomment bellow
          #modules = [ nur.nixosModules.nur ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # FIXME replace with your username@hostname
        "aimi@taiga" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux"; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
          # > Our main home-manager configuration file <
          modules = [ ./home/aimi/taiga.nix ];
        };
      };

      nixConfig = {
        extra-substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://cache.m7.rs" "https://hyprland.cachix.org" ];
        extra-trusted-public-keys = [ "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };
    };
}
