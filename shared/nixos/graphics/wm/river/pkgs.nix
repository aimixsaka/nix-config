{ lib, pkgs, ... }:

{
  home.packages = lib.attrValues {
    inherit (pkgs)
      swaybg
      copyq
      grim
      slurp
      wl-clipboard
      swappy
      pamixer
      brightnessctl
      ;
  };
}
