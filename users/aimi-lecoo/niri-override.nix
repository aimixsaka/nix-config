{
  programs.niri.settings = {
    spawn-at-startup = [
      {
        argv = [
          "swaybg"
          "--image"
          "/home/aimi/Downloads/shana.jpg"
        ];
      }
    ];
    outputs."DP-1" = {
      scale = 1.75;
      mode = {
        width = 3840;
        height = 2160;
        refresh = 120.000;
      };
    };
  };
}
