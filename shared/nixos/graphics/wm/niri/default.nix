{
  lib,
  pkgs,
  config,
  inputs',
  ...
}:
{
  imports = [
    ../../wm
    ../../wm/alacritty.nix
    ./pkgs.nix
  ];

  programs.niri = {
    enable = true;
    package = inputs'.niri.packages.niri-unstable;
    settings = {
      xwayland-satellite.path = "${lib.getExe inputs'.niri.packages.xwayland-satellite-unstable}";

      environment = {
        "DISPLAY" = ":0";
        "NIXOS_OZONE_WL" = "1";
      };
      layout = {
        gaps = 16;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        default-column-width = {
          proportion = 0.5;
        };
        focus-ring = {
          width = 4;
          active = {
            color = "#7fc8ff";
          };
          inactive = {
            color = "#505050";
          };
        };
        shadow = {
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          color = "#0007";
        };
      };
      window-rules = [
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
        {
          matches = [
            {
              app-id = "mpv";
            }
          ];
          open-floating = true;
        }
      ];
      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "alacritty";
        "Mod+D".action = spawn "fuzzel";
        "Super+Alt+L".action = spawn "swaylock";
        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;
        "Mod+F".action = maximize-column;
        "Mod+Shift+Q".action = close-window;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Shift+E".action = quit;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+U".action = move-column-to-workspace-down;
        "Mod+Shift+I".action = move-column-to-workspace-up;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+J".action = move-window-down;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+L".action = move-column-right;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        #"Mod+Ctrl+1".action = move-column-to-workspace 1;
        #"Mod+Ctrl+2".action = move-column-to-workspace 2;
        #"Mod+Ctrl+3".action = move-column-to-workspace 3;
        #"Mod+Ctrl+4".action = move-column-to-workspace 4;
        #"Mod+Ctrl+5".action = move-column-to-workspace 5;
        #"Mod+Ctrl+6".action = move-column-to-workspace 6;
        #"Mod+Ctrl+7".action = move-column-to-workspace 7;
        #"Mod+Ctrl+8".action = move-column-to-workspace 8;
        #"Mod+Ctrl+9".action = move-column-to-workspace 9;
      };
    };
  };
}
