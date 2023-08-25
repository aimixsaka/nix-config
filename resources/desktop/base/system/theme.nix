{
  pkgs,
  ...
}:

{
  # gtk
  gtk = {
      enable = true;
      #font.name = "TeX Gyre Adventor 10";
      theme = {
        name = "Arc-Dark";
        package = pkgs.arc-theme;
      };
      iconTheme = {
        name = "Arc-Dark";
        package = pkgs.arc-icon-theme;
      };

      gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

      gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # qt
  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };

}
