{ inputs, pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/cli
    ./features/games
    ./features/shells/zsh.nix
  ];
  
  wallpaper = (import ./wallpapers).shana;

  monitors = [{
    name = "eDP-1";
    width = 2736;
    height = 1824;
    isPrimary = true;
    workspace = "1";
  }];

  # Add stuff for your user as you see fit:
  #programs.neovim.enable = true;
  ## Autojump
  programs.autojump.enable = true;

  home.packages = with pkgs; [
    qq
    feishu
    # telegram desktop
    tdesktop
    # change light of screen 
    light
    # office tool
    #libreoffice
  ];
}
