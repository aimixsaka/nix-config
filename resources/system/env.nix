{
  #
  # important environment variables
  #

  # system levee
  environment.variables = {
    TMP = "/var/tmp";
    TMPDIR = "/var/tmp";
    TEMP = "/var/tmp";
  };
  # session level
  environment.sessionVariables = {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
  };
}
