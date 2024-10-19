## take from https://github.com/ryan4yin/nix-config/blob/v0.7.0/overlays/fcitx5/default.nix
(self: super: {
  rime-data = ./rime-data-flypy;
  fcitx5-rime = super.fcitx5-rime.override { rimeDataPkgs = [ ./rime-data-flypy ]; };
})
