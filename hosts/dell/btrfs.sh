sudo mount -t btrfs -o subvol=root,compress=zstd /dev/nvme0n1p6 /mnt

sudo mkdir /mnt/{home/aimi,var/lib/machines,swap,nix,boot}

for vol in home_aimi var_lib_machines swap nix; do
    sudo mount -t btrfs -o subvol=$vol /dev/nvme0n1p6 /mnt/${vol//_/\/}
done

sudo mount /dev/nvme0n1p5 /mnt/boot

sudo mkdir /mnt/home/aimi/{.cache,workspace,torrents,games,vm}
for subvol in home_aimi_{workspace,torrents,games,vm}; do
    sudo mount -t btrfs -o subvol=$subvol /dev/nvme0n1p6 /mnt/${subvol//_/\/}
done
sudo mount -t btrfs -o subvol=home_aimi_cache /dev/nvme0n1p6 /mnt/home/aimi/.cache
