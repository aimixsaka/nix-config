{
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: Roboto,'Font Awesome 5', 'SFNS Display',  Helvetica, Arial, sans-serif;
        font-size: 15px;
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

    #tags {
        background-color: #282a36;
        border-radius: 20px;
        padding: 0 15px;
    }

    #tags button {
        margin: 0 5px;
        padding: 0;
        background: transparent;
        color: #ffffff;
        border-bottom: 2px solid transparent;
    }

    #tags button.focused {
        border-bottom: 2px solid #ff79c6;
        color: #ff79c6;
    }

    #tags button.urgent {
        color: #ff5555;
    }

    #tags button:hover {
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

    #clock, #battery, #cpu, #memory, #temperature, #backlight, #network, #pulseaudio, #tray, #mode, #idle_inhibitor, #custom-todo {
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
}
