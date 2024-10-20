{
  services.gammastep = {
    enable = true;
    enableVerboseLogging = true;

    tray = true;

    provider = "manual";
    latitude = 32.1;
    longitude = 118.8;

    temperature = {
      day = 6600;
      night = 4200;
    };
    settings = {
      general.adjustment-method = "wayland";
    };
  };
}
