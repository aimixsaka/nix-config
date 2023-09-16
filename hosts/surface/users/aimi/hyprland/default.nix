{ inputs
, config
, pkgs
, ...
}:

{
  imports = [
    # specific script for set env... for Hyprland
    ./hypr-sh.nix

    ../../../../../resources/desktop/wayland/base
    ../../../../../resources/desktop/base
    inputs.hyprland.homeManagerModules.default
    
  ];

  # wallpaper
  wallpaper = (import ../../../../../resources/desktop/base/wallpapers).shana;
 
  # Session Variables for Hyprland
  #!!: Set these in hypr.sh is more apropriate?
  #home.sessionVariables = {
  #  XDG_CURRENT_DESKTOP = "Hyprland";
  #  XDG_SESSION_TYPE = "wayland";
  #  XDG_SESSION_DESKTOP = "Hyprland";
  #  
  #  ## For hidpi
  #  GDK_SCALE = 2;
  #  XCURSOR_SIZE = 32;
  #  ## Firefox
  #  MOZ_ENABLE_WAYLAND = 1;
  #  
  #  QT_AUTO_SCREEN_SCALE_FACTOR = 1;
  #  QT_QPA_PLATFORM = "wayland;xcb";
  #  QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
  #  QT_QPA_PLATFORMTHEME = "qt5ct";
  #};

  home.packages = with pkgs; [
    # hyprland xdg portal
    inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig =
      (import ./config.nix {
        inherit (config) wallpaper;
      });
  };
}
