{
  imports = [
    ./configuration.nix
    ./user.nix

    ../../shared/full-packages.nix
    ../../shared/nixos/graphics/wm/system.nix
    #../../shared/nixos/disk_layout/btrfs.nix
    #../../shared/nixos/net/dae.nix
    ../../shared/nixos/net/clash.nix
  ];
}
