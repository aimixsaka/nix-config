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
      # TODO: use home manager module to manage fuzzel
      fuzzel
      ;
  };
}
