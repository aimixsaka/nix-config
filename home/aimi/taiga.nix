{ inputs, pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/cli
    ./features/games
    ./features/shells/zsh.nix
    ./features/editors/nvim
    #./features/editors/vim
  ];
  
  wallpaper = (import ./wallpapers).shana;

  # monitors = [
  #   {
  #     name = "eDP-1";
  #     width = 2736;
  #     height = 1824;
  #     isPrimary = true;
  #     workspace = "1";
  #   },
  # ];

}
