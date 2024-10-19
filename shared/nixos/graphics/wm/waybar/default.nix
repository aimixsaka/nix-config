{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    pavucontrol
  ];
  programs.waybar.enable = true;
  imports = [
    ./style.nix
    ./config.nix
  ];
}
