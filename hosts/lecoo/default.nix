{ pkgs, config, ... }:
{
  imports = [
    ./configuration.nix
    ./user.nix

    ../../shared/full-packages.nix
    ../../shared/nixos/graphics/wm/system.nix
    #../../shared/nixos/disk_layout/btrfs.nix
    #../../shared/nixos/net/dae.nix
    ../../shared/nixos/net/clash.nix
    ../../shared/nixos/graphics/apps/android.nix
    (import ../../shared/nixos/net/aria2.nix {
      inherit pkgs config;
      domain = "giga.amx.moe";
    })
  ];
}
