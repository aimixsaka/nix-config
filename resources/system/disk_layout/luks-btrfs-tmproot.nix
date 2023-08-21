{ 
  disks ? [ "/dev/vda" ],
  ... 
}: 

{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "1MiB";
              end = "512MiB";
              bootable = true;
              content = {
                type = "filesystem";
                # set label
                extraArgs = [ "-n" "ESP" ]; 
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            }
            {
              name = "luks";
              start = "512MiB";
              end = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ "--allow-discards" ];
				        passwordFile = "/tmp/secret.key"; # Interactive
                #keyFile = "/tmp/secret.key";
                content = {
				  type = "btrfs";
				  # set label
				  extraArgs = [ "-f" "--label" "taiga" ]; 
				  # Subvolumes must set a mountpoint in order to be mounted,
				  # unless their parent is mounted
				  subvolumes = {
					# Parent is not mounted so the mountpoint must be set
					"/nix" = {
					  mountOptions = [ "compress=zstd" "noatime" ];
					  mountpoint = "/nix";
					};

					"/persist" = {
					  mountOptions = [ "compress=zstd" ];
					  mountpoint = "/persist";
					};

					"/swap" = {
					  mountOptions = [ "noatime" ];
					  mountpoint = "/swap";
					};
				  };
                };
              };
            }
          ];
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=12G"
          "mode=755"
        ];
      };
    };
  };
}
