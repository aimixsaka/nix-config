## NOTE
**Temporarily archive this repo to focus on server side of NixOS**

## TODO
- [ ] move hyprland and i3... to resources. accept `config` parameter. call them in users dir
- [ ] change locale config from system level(nixos configuration) to user level(home-manager)
- [ ] consider automation of fcitx5 addon cache(put addon cache to cloud or something else, then override fcitx5-rime's rimeDataPkgs, using fetchTarball or other). see https://github.com/ryan4yin/nix-config/blob/v0.0.4/overlays/fcitx5/default.nix
- [ ] improve fontconfig 
- [x] reenable nixos-hardware surface-intel support(surface-kernel...)
- [ ] create config for my qemu vm for building
- [ ] create pkgs and overlays dir, add self packed pkgs through overlays
- [x] create nixos service for xray to support transparent proxy.(named with `zxray`)
