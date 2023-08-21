{ config
, ... 
}:

let 
  hostname = config.networking.hostName;
in

{
  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=12G" "mode=755" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };

    "/nix" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "compress=zstd" ];
    };

    "/persist" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" ];
      neededForBoot = true;
    };

    "/swap" = {
        device = "/dev/disk/by-label/${hostname}";
        fsType = "btrfs";
        options = [ "subvol=swap" "noatime" ];
    };
  };

  swapDevices = [{ 
    device = "/swap/swapfile";
    size = 8196;
  }];

}
