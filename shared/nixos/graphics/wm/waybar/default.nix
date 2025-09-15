{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    pavucontrol
    blueman
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  imports = [
    ./style.nix
    ./config.nix
  ];
}
