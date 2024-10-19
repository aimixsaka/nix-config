{
  services.mako = {
    enable = true;
    backgroundColor = "#303446";
    textColor = "#c6d0f5";
    borderColor = "#8caaee";
    borderRadius = 10;
    progressColor = "over #414559";
    maxVisible = 3;
    defaultTimeout = 6000;

    extraConfig = ''
      [urgency=high]
      border-color=#ef9f76
    '';
  };
}
