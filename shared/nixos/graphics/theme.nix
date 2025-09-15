{ pkgs, ... }:

{
  # theme
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
    targets.waybar.enable = false;
  };
}
