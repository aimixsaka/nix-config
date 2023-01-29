{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ../common
    ../common/wayland-wm
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    swaybg  
  ];
 
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
  #  
  #  QT_AUTO_SCREEN_SCALE_FACTOR = 1;
  #  QT_QPA_PLATFORM = "wayland;xcb";
  #  QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
  #  QT_QPA_PLATFORMTHEME = qt5ct;
  #};

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig =
      (import ./monitors.nix {
        inherit lib;
        inherit (config) monitors;
      }) +
      (import ./config.nix {
        inherit (config) wallpaper;
      });
  };
}
