{ pkgs
, inputs
, ...
}:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        height = 30; # Waybar height
        # modules-left = ["hyprland/window" "clock"];
        modules-left = [ 
          "clock"
        ];
        modules-center = [
          "hyprland/workspaces" 
        ];
        modules-right = [ 
          "cpu"
          "pulseaudio"
          "battery"
          "network"
          "tray"
        ];
        mode = {
	  docked = {
	    output = [ "eDP-1" ];
 	  };
        };
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
        "hyprland/window" = {
          max-length = 50;
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
          format = "{:%H:%M:%S}";
          tooltip = false;
        };

        "clock#date" = {
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
              default = [ "" "" ];
          };
          on-click = "pavucontrol";
        };
      };
    };

    
    # bakup for font-family in * {
    # font-family: Roboto,'Font Awesome 5', 'SFNS Display',  Helvetica, Arial, sans-serif;
    style = '' 
      * {
          border: none;
          border-radius: 0;
          font-size: 20px;
          min-height: 0;
      }
      
      window#waybar {
          background: rgba(0,0,0,0);
          color: #ffffff;
      }
      
      window#waybar.hidden {
          opacity: 0.0;
      }
      
      #workspaces {
          background-color: #282a36;
          border-radius: 20px;
          padding: 0 15px;
      }
      
      #workspaces button {
          margin: 0 5px;
          padding: 0;
          background: transparent;
          color: #ffffff;
          border-bottom: 2px solid transparent;
      }
      
      #workspaces button.focused {
          border-bottom: 2px solid #ff79c6;
          color: #ff79c6;
      }
      
      #workspaces button.urgent {
          color: #ff5555;
      }
      
      #workspaces button:hover {
          box-shadow: none;
          text-shadow: none;
          border-bottom: 2px solid #ff79c6;
      }
      
      #window {
          background-color: #282a36;
          border-radius: 0 20px 20px 0;
          padding: 0 20px;
          margin: 0 10px 0 0;
      }
      
      #clock, #battery, #cpu, #memory, #temperature, #backlight, #network, #pulseaudio, #custom-media, #tray, #mode, #idle_inhibitor {
          padding: 0 20px;
          margin: 0 10px;
          background-color: #282a36;
          color: #ffffff;
          border-radius: 20px;
      }
      
      #clock {
          
      }
      
      #battery {
      }
      
      #battery.charging {
      }
      
      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }
      
      #battery.critical:not(.charging) {
          background: #f53c3c;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      #cpu {
      }
      
      #memory {
      }
      
      #backlight {
      }
      
      #network {
          margin: 0 0 0 10px;
          padding:  0 10px 0 20px;
          border-radius: 20px 0 0 20px;
      }
      
      #network.disconnected {
      }
      
      #pulseaudio {
      }
      
      #pulseaudio.muted {
      }
      
      #custom-media {
      }
      
      .custom-spotify {
      }
      
      .custom-vlc {
      }
      
      #temperature {
      }
      
      #temperature.critical {
      }
      
      #tray {
          border-radius: 0;
          margin: 0;
          padding: 0 20px 0 0;
      }
      
      #idle_inhibitor {
      }
      
      #idle_inhibitor.activated {
      }
    '';
  };
}
