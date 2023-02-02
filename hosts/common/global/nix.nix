{ pkgs, inputs, lib, config, ... }:
{
  nix = {
    settings = {
      substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://hyprland.cachix.org" ];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];

      trusted-users = [ "root" "@wheel" ];
      # Deduplicate and optimize nix store
      auto-optimise-store = lib.mkDefault true;

      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
      system-features = [ "kvm" "big-parallel" ];
    };
    package = pkgs.nixUnstable;
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
}
