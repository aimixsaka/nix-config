{
  lib,
  ...
}:

{
  programs.waybar = {
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "clock"
        ];
        modules-center = lib.mkDefault [
          "river/tags"
        ];
        modules-right = [
          "cpu"
          "pulseaudio"
          "battery"
          "network"
          "tray"
        ];
        #mode = {
        #  docked = {
        #    output = [ "eDP-1" ];
        #  };
        #};
        # Modules configuration
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "  {icon}  ";
          format-icons = {
            "1" = "  ";
            "2" = "  ";
            "3" = "  ";
            "4" = "  ";
            "5" = "  ";
            "6" = "  ";
            "7" = "  ";
            "8" = "  ";
            "9" = " ";
            active = "<span color=\"red\"></span>";
            urgent = "";
            default = "";
          };
          sort-by-number = true;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
        "clock" = {
          interval = 1;
          format = "<span color=\"#ff5555\"></span>  {:%H : %M : %S}";
          format-alt = "<span color=\"#bd93f9\"></span>   {:%d / %m / %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        "clock#time" = {
          interval = 1;
          timezone = "Asia/Shanghai";
          format = "{:%H:%M:%S}";
          tooltip = false;
        };

        "clock#date" = {
          timezone = "Asia/Shanghai";
          interval = 10;
          format = "  {:%e %b %Y}"; # Icon = calendar-alt
          #tooltip-format = "{:%e %B %Y}";
        };
        "cpu" = {
          format = "<span color=\"#f1fa8c\"></span>  {usage}%  ({load})";
        };
        "memory" = {
          format = "{}% ";
        };
        "battery" = {
          interval = 10;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          # format-good = ""; # An empty format will hide the module
          # format-full = "";
          format-charging = "<span color=\"#37E614\"></span> {capacity}%";
          #format-plugged = "{capacity}% ";
          format-icons = [
            "<span color=\"#ff5555\"></span>"
            "<span color=\"#ffb86c\"></span>"
            "<span color=\"#f1fa8c\"></span>"
            "<span color=\"#50fa7b\"></span>"
            "<span color=\"#50fa7b\"></span>"
          ];
        };
        "network" = {
          # interface = "wlp2s0"; # (Optional) To force the use of this interface
          format-wifi = "";
          format-ethernet = "";
          format-disconnected = "⚠";
          format-alt = "{ipaddr}";
          # format to show when hovered
          tooltip-format = "{essid}";
          interval = 7;
        };
        "pulseaudio" = {
          # scroll-step = 1;
          format = "<span color=\"#8be9fd\">{icon}</span>  {volume}%";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            default = [
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
      };
    };
  };
}
