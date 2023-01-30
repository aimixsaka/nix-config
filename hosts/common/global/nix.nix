{ pkgs, inputs, lib, config, ... }:
{
  nix = {
    # Deduplicate and optimize nix store
    auto-optimise-store = lib.mkDefault true;
    trusted-users = [ "root" "@wheel" ];
    auto-optimise-store = lib.mkDefault true;
    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    #warn-dirty = false;
    system-features = [ "kvm" "big-parallel" ];
    package = pkgs.nixUnstable;
    gc = {
      automatic = true;
      dates = "weekly";
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    #registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Map registries to channels
    # Very useful when using legacy commands
    #nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };

    substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://hyprland.cachix.org" ];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
