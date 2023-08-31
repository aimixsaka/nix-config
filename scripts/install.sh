read -p "Please input your password for luks: " -r psk
echo -n "$psk" > /tmp/secret.key


nix --extra-experimental-features nix-command \
	--extra-experimental-features flakes \
	run --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store" \
	github:nix-community/disko -- --mode disko "${2:-resources/system/disk_layout/luks-btrfs-tmproot.nix}" --arg disks "[ \"$1\" ]"
