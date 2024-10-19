{
  disk ? "/dev/nvme0n1",
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
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512MiB";
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

                  "home_aimi" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home/aimi";
                  };

                  "home_aimi_torrents" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home/aimi/torrents";
                  };

                  "home_aimi_vm" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home/aimi/vm";
                  };

                  "home_aimi_games" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home/aimi/games";
                  };

                  "home_aimi_cache" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home/aimi/.cache";
                  };

                  "home_aimi_workspace" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home/aimi/workspace";
                  };

                  "var_lib_machines" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/var/lib/machines";
                  };

                  "swap" = {
                    mountOptions = [ "noatime" ];
                    mountpoint = "/swap";
                    swap = {
                      swapfile.size = "20G";
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
