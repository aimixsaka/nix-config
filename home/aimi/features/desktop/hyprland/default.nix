{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ../common
    ../common/wayland-wm
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    swaybg  
    swaylock
    wl-clipboard

    #An XDG Desktop Portal (later called XDP) is a program that lets other applications communicate swiftly with the compositor through D-Bus.
    #It’s used for stuff like e.g. opening file pickers, screen sharing.
    #On Wayland, it also requires an implementation. For Hyprland, you’d usually use xdg-desktop-portal-wlr (later called XDPW)
    #inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland

    #!!! not be here, should be ~/nix-config/hosts/taiga/default.nix
    #xdg-desktop-portal-wlr
    #xdg-desktop-portal-gtk
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
  #  ## Firefox
  #  MOZ_ENABLE_WAYLAND = 1;
  #  
  #  QT_AUTO_SCREEN_SCALE_FACTOR = 1;
  #  QT_QPA_PLATFORM = "wayland;xcb";
  #  QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
  #  QT_QPA_PLATFORMTHEME = "qt5ct";
  #};

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig =
      (import ./config.nix {
        inherit (config) wallpaper;
      });
  };
}
