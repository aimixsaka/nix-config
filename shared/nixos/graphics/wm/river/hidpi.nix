{ pkgs, ... }:

{
  services.way-displays = {
    enable = true;
    settings = {
      SCALE = [
        {
          NAME_DESC = "eDP-1";
          SCALE = 1.75;
        }
      ];
    };
  };
  # Mouse/Cursor scaling for consistency across all apps (electron & xwayland)
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    gtk.enable = true;
    x11.enable = true;
    size = 24;
  };
  xresources.properties = {
    # Xresources for xwayland apps
    "Xcursor*size" = 24;
  };
}
