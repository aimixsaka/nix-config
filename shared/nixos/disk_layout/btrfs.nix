{
  fileSystems = {
    "/" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=root"
        "compress=zstd"
      ];
    };
    "/home/aimi" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=home_aimi"
        "compress=zstd"
      ];
    };
    "/home/aimi/torrents" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=home_aimi_torrents"
        "compress=zstd"
      ];
    };
    "/home/aimi/vm" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=home_aimi_vm"
        "compress=zstd"
      ];
    };
    "/home/aimi/games" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=home_aimi_games"
        "compress=zstd"
      ];
    };
    "/home/aimi/.cache" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=home_aimi_cache"
        "compress=zstd"
      ];
    };
    "/home/aimi/workspace" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=home_aimi_workspace"
        "compress=zstd"
      ];
    };
    "/var/lib/machines" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=var_lib_machines"
        "compress=zstd"
      ];
    };
    "/nix" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };
    "/swap" = {
      fsType = "btrfs";
      device = "/dev/disk/by-partlabel/aimiroot";
      options = [
        "subvol=swap"
        "noatime"
      ];
    };

    "/boot" = {
      fsType = "vfat";
      device = "/dev/disk/by-partlabel/aimiboot";
    };
  };
  swapDevices = [ { device = "/swap/swapfile"; } ];
}
