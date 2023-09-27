{ 
  pkgs,
  inputs,
  lib,
  config,
  ... 
}:

{
  nix = {
    settings = {
      substituters = lib.mkBefore [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        # nix community's cache server
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      trusted-users = [ "aimi" "root" "@wheel" ];
      # Deduplicate and optimize nix store
      auto-optimise-store = lib.mkDefault true;

      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
      system-features = [ "kvm" "big-parallel" ];
    };
    #package = pkgs.nixUnstable;
    ## do not need auto gc
    #gc = {
    #  automatic = true;
    #  # default is "03:15"
    #  dates = "21:00";
    #};

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    #registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Map registries to channels
    # Very useful when using legacy commands
    #nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

  };

  ## NIX_PATH and flake registry
  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  nix.nixPath = ["/etc/nix/inputs"];
}
