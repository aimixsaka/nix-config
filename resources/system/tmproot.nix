{ ... }:

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
      device = "/dev/disk/by-label/taiga";
      fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "compress=zstd" ];
    };

    "/swap" = {
        device = "/dev/disk/by-label/taiga";
        fsType = "btrfs";
        options = [ "subvol=swap" "noatime" ];
    };
  };
}
