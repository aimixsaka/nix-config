{ inputs }:

{
  # nix path's nixpkgs follow inputs one
  nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # make commands like `nix run` follow flake.nix inputs
  registry = {
    system.flake = inputs.self;
    default.flake = inputs.nixpkgs;
    home-manager.flake = inputs.home;
  };

  settings = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];

    trusted-substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store/?priority=10"
      "https://cache.nixos.org?priority=7"
      "https://nix-community.cachix.org?priority=5"
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-gaming.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];

    trusted-users = [
      "root"
      "aimi"
      "nixos"
    ];
    # FIXME: what does this mean?
    #use-xdg-base-directories = true;
  };
}
