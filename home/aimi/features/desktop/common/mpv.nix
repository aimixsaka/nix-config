{ pkgs, config, ... }:
{
  programs.mpv = {
    enable = true;

    config = {
      # Specify high quality video rendering preset (for --vo=gpu only)
      # Can cause performance problems with some drivers and GPUs.
      profile = "gpu-hq";
      # for color
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      video-sync = "display-resample";
      interpolation = true;
      tscale = "oversample";

      blend-subtitles = "video";
      sub-auto = "fuzzy";

      # Enable hardware decoding if available. Often, this does not work with all
      # video outputs, but should work well with default settings on most systems.
      # If performance or energy usage is an issue, forcing the vdpau or vaapi VOs
      # may or may not help.
      hwdec = "auto";

      # set default volume
      volume = 52;
    };

    bindings = {
      # seek 1 minute forward
      l = "seek 5";
      # seek 1 minute backward
      h  = "seek -5";
      # seek 1 minute forward
      L = "seek 60";
      # seek 1 minute backward
      H = "seek -60";

      k = "add volume 2";
      j = "add volume -2";

      WHEEL_UP = "add volume 1";
      WHEEL_DOWN = "add volume -1";
    };
  };
}
