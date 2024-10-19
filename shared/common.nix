{
  ## openssh
  services.openssh = {
    enable = true;
    ports = [ 52842 ];
    # Forbid root login through SSH.
    settings = {
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };
}
