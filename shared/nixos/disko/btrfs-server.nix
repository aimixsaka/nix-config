{
  disk ? "/dev/vda",
  ...
}:
{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = disk;
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };

            esp = {
              name = "ESP";
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                # set label
                extraArgs = [
                  "-n"
                  "ESP"
                ];
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                # set label
                extraArgs = [
                  "-f"
                  "--label"
                  "amxroot"
                ];
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Parent is not mounted so the mountpoint must be set
                  "nix" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };

                  "root" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/";
                  };

                  "swap" = {
                    mountOptions = [ "noatime" ];
                    mountpoint = "/swap";
                    swap = {
                      swapfile.size = "2G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
