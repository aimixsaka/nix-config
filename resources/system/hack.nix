{
  #
  # fix home-manager error:
  #
  #error: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name ca.desrt.dconf was not provided by any .service files
  # when using gtk.enable = true
  programs.dconf.enable = true;


  #
  # fix swaylock always wrong password error
  #
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # TODO:
  # fix podman error 'Error: statfs /lib/modules: no such file or directory'

  #
  # fix iptsd.service error after resume from suspend or hibernate
  # (reason stil unknown)
  powerManagement.resumeCommands = ''
    systemctl restart iptsd.service
  '';

}
