{
  description = "aimi flake config for macos";

  outputs =
    inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];
      imports = [
        ./modules/parts
        ./overlays
        ./hosts
        ./users
      ];
      flake.hmModules.default = import ./modules/home-manager;
      flake.nixosModules.default = import ./modules/nixos;
    };
  #// {
  #  hmModules.default = import ./modules/home-manager;
  #  nixosModules.default = import ./modules/nixos;
  #};

  inputs = {
    ### -- nix lang & nixpkgs help
    parts.url = "github:hercules-ci/flake-parts";
    nix-index-database.url = "github:nix-community/nix-index-database";

    ### -- nixpkgs
    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/release-24.05";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    # emacs-macport for x86_64-darwin broken after this commit
    pkgs-emacs-macport.url = "github:nixos/nixpkgs/038fb464fcfa79b4f08131b07f2d8c9a6bcc4160";

    # Default Nixpkgs for packages and modules
    nixpkgs.follows = "master";

    ### -- overlays
    emacs-overlays.url = "github:nix-community/emacs-overlay";

    ### -- platform support
    darwin.url = "github:LnL7/nix-darwin";
    home.url = "github:nix-community/home-manager";

    ### -- install tools
    disko.url = "github:nix-community/disko";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    # Minimize duplicate instances of inputs
    nix.inputs.nixpkgs.follows = "nixpkgs";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlays.inputs.nixpkgs.follows = "nixpkgs";
  };

  # the nixConfig affects the flake itself,
  # not the system configuration
  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
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
    ];
  };

}
