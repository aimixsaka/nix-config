{
  # fix home-manager error:
  #error: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name ca.desrt.dconf was not provided by any .service files
  # when using gtk.enable = true
  programs.dconf.enable = true;
}