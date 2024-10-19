{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../wm
  ];
  home.packages = lib.attrValues {
    inherit (pkgs)
      swaybg
      copyq
      grim
      slurp
      ;
  };
  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;

    extraSessionVariables = {
      XDG_CURRENT_DESKTOP = "river";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    extraConfig = ''
      riverctl spawn "swaybg -m fill -i ${./shana.jpg}"
      riverctl spawn "mako"
      riverctl spawn "waybar"
      #riverctl spawn "fcitx5 -d"
      riverctl spawn "copyq --start-server"

riverctl map normal Super C spawn 'grim -g "$(slurp)" - | wl-copy && notify-send "Screenshot Copied to Clipboard"'
riverctl map normal Super+Shift C spawn 'grim -g $(slurp) - | swappy -f -'
riverctl map normal Print spawn /home/aimi/workspace/shell/screenshot.sh

#riverctl keyboard-layout -options "ctrl:nocaps,altwin:swap_alt_win" us
riverctl keyboard-layout -options "ctrl:nocaps" us
riverctl map normal Super Return spawn "if pgrep alacritty &>/dev/null; then alacritty msg create-window; else alacritty; fi"
riverctl map normal Super D spawn 'wofi --show drun --lines=5 --prompt=""'

riverctl map normal Super Backspace spawn "pamixer -t"

riverctl map normal Super+Shift Q close

riverctl map normal Super+Shift E exit

riverctl map normal Super H focus-view left
riverctl map normal Super L focus-view right
riverctl map normal Super J focus-view down
riverctl map normal Super K focus-view up

riverctl map normal Super+Shift H swap left
riverctl map normal Super+Shift L swap right
riverctl map normal Super+Shift J swap down
riverctl map normal Super+Shift K swap up

# Super+Period and Super+Comma to focus the next/previous output
#riverctl map normal Super Period focus-output next
#riverctl map normal Super Comma focus-output previous

# Super+Shift+{Period,Comma} to send the focused view to the next/previous output
#riverctl map normal Super+Shift Period send-to-output next
#riverctl map normal Super+Shift Comma send-to-output previous

# Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
#riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
#riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

# Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
#riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
#riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"

# Super+Alt+{H,J,K,L} to move views
riverctl map normal Control+Super Left move left 100
riverctl map normal Control+Super Down move down 100
riverctl map normal Control+Super Up move up 100
riverctl map normal Control+Super Right move right 100

# Super+Alt+Control+{H,J,K,L} to snap views to screen edges
riverctl map normal Super+Alt+Control H snap left
riverctl map normal Super+Alt+Control J snap down
riverctl map normal Super+Alt+Control K snap up
riverctl map normal Super+Alt+Control L snap right

# adjust main window size
riverctl map normal Control+Super H send-layout-cmd rivertile 'main-ratio -0.05'
riverctl map normal Control+Super L send-layout-cmd rivertile 'main-ratio +0.05'

riverctl map normal Control+Super J send-layout-cmd rivertile 'main-count -1'
riverctl map normal Control+Super K send-layout-cmd rivertile 'main-count +1'

# Super + Left Mouse Button to move views
riverctl map-pointer normal Super BTN_LEFT move-view

# Super + Right Mouse Button to resize views
riverctl map-pointer normal Super BTN_RIGHT resize-view

# Super + Middle Mouse Button to toggle float
riverctl map-pointer normal Super BTN_MIDDLE toggle-float

for i in $(seq 1 9); do
    tags=$((1 << (i - 1)))

    # Super+[1-9] to focus tag [0-8]
    riverctl map normal Super $i set-focused-tags $tags

    # Super+Shift+[1-9] to tag focused view with tag [0-8]
    riverctl map normal Super+Shift $i set-view-tags $tags

    # Super+Control+[1-9] to toggle focus of tag [0-8]
    #riverctl map normal Super+Control $i toggle-focused-tags $tags

    # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
    #riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
done

## cycle tags
riverctl map normal Super comma spawn "cycle-focused-tags -1 9"
riverctl map normal Super period spawn "cycle-focused-tags +1 9"

# Super+0 to focus all tags
# Super+Shift+0 to tag focused view with all tags
#all_tags=$(((1 << 32) - 1))
#riverctl map normal Super 0 set-focused-tags $all_tags
#riverctl map normal Super+Shift 1 set-view-tags $all_tags

# zoom
riverctl map normal Super Space zoom

riverctl map normal Super+Shift Space toggle-float

# Super+F to toggle fullscreen
riverctl map normal Super F toggle-fullscreen

# Super+{Up,Right,Down,Left} to change layout orientation
riverctl map normal Super Up send-layout-cmd rivertile "main-location top"
riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
riverctl map normal Super Down send-layout-cmd rivertile "main-location bottom"
riverctl map normal Super Left send-layout-cmd rivertile "main-location left"

# Declare a passthrough mode. This mode has only a single mapping to return to
# normal mode. This makes it useful for testing a nested wayland compositor
riverctl declare-mode passthrough

# Super+F11 to enter passthrough mode
riverctl map normal Super F11 enter-mode passthrough

# Super+F11 to return to normal mode
riverctl map passthrough Super F11 enter-mode normal

# Various media key mapping examples for both normal and locked mode which do
# not have a modifier
for mode in normal locked; do
    # Eject the optical drive (well if you still have one that is)
    riverctl map $mode None XF86Eject spawn 'eject -T'

    # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
    riverctl map $mode None XF86AudioRaiseVolume spawn 'pamixer -i 5'
    riverctl map $mode None XF86AudioLowerVolume spawn 'pamixer -d 5'
    riverctl map $mode None XF86AudioMute spawn 'pamixer --toggle-mute'

    # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
    riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPlay spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPrev spawn 'playerctl previous'
    riverctl map $mode None XF86AudioNext spawn 'playerctl next'

    # Control screen backlight brightness with brightnessctl (https://github.com/Hummer12007/brightnessctl)
    riverctl map $mode None XF86MonBrightnessUp spawn 'brightnessctl set +5%'
    riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
done

# Set background and border color
riverctl background-color 0x002b36
riverctl border-color-focused 0x0750bf
riverctl border-color-unfocused 0x5959a

# Set keyboard repeat rate
riverctl set-repeat 50 300

# Make all views with an app-id that starts with "float" and title "foo" start floating.
float_apps=(
    'Godot'
    'bobx'
    'IDA'
    'org.kde.dolphin'
)
for app in "''${float_apps[@]}"; do
    riverctl rule-add -app-id "$app" float
done

# Make all views with app-id "bar" and any title use client-side decorations
#riverctl rule-add -app-id "bar" csd

# new window will on top layer
riverctl default-attach-mode top

# Set the default layout generator to be rivertile and start it.
# River will send the process group of the init executable SIGTERM on exit.
riverctl default-layout rivertile
rivertile -view-padding 6 -outer-padding 6 &
    '';
  };
}
