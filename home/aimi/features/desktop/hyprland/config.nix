{ wallpaper }:
''
  ##################
  ###  GENERAL  ###
  ##################
  $Mod = SUPER
  $Mod_S = SUPER_SHIFT
  $Mod_A = SUPER_ALT
  $Mod_C = SUPER_CTRL
  general {
      gaps_in = 3
      gaps_out = 3
      border_size = 2
      no_border_on_floating = true
      col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      col.inactive_border = rgba(595959aa)
      col.group_border = rgba(595959aa)
      col.group_border_active = rgb(ff00cc) rgb(ff0000) 45deg
      # col.active_border = rgb(f49bc1) rgb(ff0000) 45deg
      # col.inactive_border = rgba(595959aa)
      layout = dwindle
  }
  
  
  ##################
  ###    EXEC    ###
  ##################
  #exec-once = bash ~/xdph.sh
  exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
  exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  exec = swaybg -i ${wallpaper} --mode fill
  #exec-once = hyprpaper --config ~/.config/hypr/hyprpaper.conf
  exec-once = waybar
  exec-once = hyprctl setcursor Bibata-Modern-Classic 50
  ## High cpu cost!?(no, its my miss)
  # use gammastep instead
  #exec-once = wlsunset -S 7:40 -s 17:30
  #exec-once = gammastep -l geoclue2 -m wayland -t 6000:4000
  exec-once = wl-clipboard-history -t
  exec-once = fcitx5 -d
  exec-once = mako 
  
  
  ##################
  ###    EXEC    ###
  ##################
  #monitor = eDP-1, 2736x1824@59.959000, 0x0, 1
  # Not needed, already defined in
  # hyprland/default.nix, wayland.windowManager.hyprland.extraConfig
  monitor = eDP-1, 2736x1824, 0x0, 1
  #monitor = eDP-1, 2736x1824, 0x0, 1, mirror, eDP-2
  
  
  ##################
  ###   INPUT   ###
  ##################
  input {
      kb_layout = us
      # exchange caps and escape
      kb_options = caps:swapescape
      follow_mouse = 0
      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
  
      touchpad {
          # other setting' default value is ok
          middle_button_emulation = true 
          natural_scroll = true 
      }
  }
  
  
  ##################
  ###    MISC    ###
  ##################
  misc {
    disable_hyprland_logo = true
    disable_splash_rendering = false
    mouse_move_enables_dpms = true
    # VFR increases battery life
    #no_vfr = false
    #enable_swallow = true
    swallow_regex = ^(Alacritty)$
  
    # Whether Hyprland should focus an app that requests to be focused 
    focus_on_activate = true
  }
  
  
  ##################
  ### DECORATION ###
  ##################
  decoration {
    ## Round Corner
    rounding = 8
    multisample_edges = true
  
    ## Opacity
    active_opacity = 0.93
    inactive_opacity = 0.80
  
    ## Blur
    blur = false
    blur_size = 2
    blur_passes = 3
    blur_new_optimizations = true
  
  
    ## Shadow
    drop_shadow = true
    shadow_ignore_window = true
    shadow_offset = 2 2
    shadow_range = 4
    shadow_render_power = 2
    col.shadow = 0x66000000
  }
  
  
  ###################
  ###  ANIMATIONS ###
  ###################
  animations {
    enabled = true
    ## Bezier Curve
    bezier = overshot, 0.05, 0.9, 0.1, 1.05
    bezier = smoothOut, 0.36, 0, 0.66, -0.56
    bezier = smoothIn, 0.25, 1, 0.5, 1
  
    animation = windows, 1, 3, overshot, slide
    animation = windowsOut, 1, 3, smoothOut, slide
    animation = windowsMove, 1, 3, default
    animation = border, 1, 10, default
    animation = fade, 1, 10, smoothIn
    animation = fadeDim, 1, 10, smoothIn
    animation = workspaces, 1, 6, default
  
  }
  
  ##################
  ###  DWINDLE  ###
  ##################
  dwindle {
      no_gaps_when_only = false
      pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true # you probably want this
  }
  
  
  ####################
  ### WINDOW RULES ###
  ####################
  windowrule = float, file_progress
  windowrule = float, confirm
  windowrule = float, dialog
  windowrule = float, download
  windowrule = float, notification
  windowrule = float, error
  windowrule = float, splash
  windowrule = float, confirmreset
  windowrule = float, title:Open File
  windowrule = float, title:branchdialog
  windowrule = float, Lxappearance
  windowrule = float, wofi
  windowrule = animation none,wofi
  windowrule = float,viewnior
  windowrule = float,feh
  windowrule = float, pavucontrol-qt
  windowrule = float, pavucontrol
  windowrule = float, file-roller
  windowrule = fullscreen, wlogout
  windowrule = float, title:wlogout
  windowrule = fullscreen, title:wlogout
  windowrule = idleinhibit focus, mpv
  windowrule = idleinhibit fullscreen, firefox
  windowrule = float, title:^(Media viewer)$
  windowrule = float, title:^(Volume Control)$
  windowrule = float, title:^(Picture-in-Picture)$
  windowrule = size 800 600, title:^(Volume Control)$
  windowrule = move 75 44%, title:^(Volume Control)$
  windowrulev2 = workspace 1, class:^(marktext)$
  windowrulev2 = workspace 2, title:^(Telegram)$
  windowrulev2 = workspace 2, class:^(Bytedance-feishu)$
  windowrulev2 = workspace 2, class:^(QQ)$
  windowrulev2 = workspace 4, class:^(steam)(.*)$
  windowrulev2 = workspace 4, class:^(Steam)(.*)$
  windowrulev2 = opacity 1.0 override 1.0 override, class:^(steam_app_888790)$
  
  ##################
  ###  KEYBIND  ###
  ##################
  
  ## ScreenShot
  #$screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"
  #bind = $Mod_S, S, exec, $screenshotarea
  #bind = , Print, exec, grimblast --notify --cursor copysave output
  #bind = ALT, Print, exec, grimblast --notify --cursor copysave screen
  
  #bind = $Mod_S, C, exec, grim -g "$(slurp)" ~/Pictures/screenshots/$(date +'%Y:%m:%d:%H:%M:%S.png')
  bind = $Mod, C, exec, grim -g  "$(slurp)" - | wl-copy -t image/png
  #bind = $Mod, C, exec,grim -g "$(slurp)" - | swappy -f -
  bind = , Print, exec, grim -g "$(slurp)" - | swappy -f -
  
  ## Sound
  bind = , XF86AudioLowerVolume, exec, pamixer -d 3
  bind = , XF86AudioRaiseVolume, exec, pamixer -i 3

  ## Light
  bind = , XF86MonBrightnessDown, exec, brightnessctl set 3%-
  bind = , XF86MonBrightnessUp, exec, brightnessctl set +3%
  
  
  ##################
  ###    MISC    ###
  ##################
  bind = $Mod, X, exec, hyprpicker -a -n
  #bind = $Mod_S, Tab, exec, swaylock -f -c 000000
  bind = $Mod, Return, exec, alacritty
  bind = $Mod, E, exec, thunar
  bind = $Mod, D, exec, wofi --show=drun --lines=5 --prompt=""
  bind = $Mod, escape, exec, wlogout --protocol layer-shell -b 5 -T 400 -B 400
  bind = $Mod, A, exec, hyprctl activewindow
  
  #########################
  ### WINDOW MANAGEMENT ###
  #########################
  bind = $Mod_S, Q, killactive,
  bind = $Mod_S, E, exit,
  bind = $Mod, F, fullscreen,
  bind = $Mod_S, Space, togglefloating,
  # float termial apperance? (be smaller)
  bind = $Mod, P, pseudo, # dwindle
  # such as horizontal -> vertical
  bind = $Mod, S, togglesplit, # dwindle
  
  
  # bind=,Print,exec,grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%Y%m%d%H%M%S_1.png') && notify-send 'Screenshot Saved'
  # bind=$Mod,Print,exec,grim - | wl-copy && notify-send 'Screenshot Copied to Clipboard'
  # bind=$ModSHIFT,Print,exec,grim - | swappy -f -
  # bind=$ModSHIFT,S,exec,slurp | grim -g - $(xdg-user-dir PICTURES)/Screenshots/$(date +'%Y%m%d%H%M%S_1.png') && notify-send 'Screenshot Saved'
  
  ##################
  ###   FOCUS   ###
  ##################
  bind = $Mod, H, movefocus, l
  bind = $Mod, L, movefocus, r
  bind = $Mod, K, movefocus, u
  bind = $Mod, J, movefocus, d
  
  ##################
  ###    MOVE    ###
  ##################
  bind = $Mod_S, H, movewindow, l
  bind = $Mod_S, L, movewindow, r
  bind = $Mod_S, K, movewindow, u
  bind = $Mod_S, J, movewindow, d
  
  ##################
  ###   RESIZE   ###
  ##################
  bind = $Mod_C, H, resizeactive, -20 0
  bind = $Mod_C, L, resizeactive, 20 0
  bind = $Mod_C, K, resizeactive, 0 -20
  bind = $Mod_C, J, resizeactive, 0 20
  
  #######################
  ### TABBED(GROUPED) ###
  #######################
  ## Refer to DWINDLE
  bind = $Mod, G, togglegroup
  bind = $Mod, Tab, changegroupactive
  
  ##################
  ###  SPECIAL  ###
  ##################
  bind = $Mod, grave, togglespecialworkspace
  bind = $ModSHIFT, grave, movetoworkspace, special
  
  ##################
  ###   SWITCH   ###
  ##################
  bind = $Mod, 1, workspace, 1
  bind = $Mod, 2, workspace, 2
  bind = $Mod, 3, workspace, 3
  bind = $Mod, 4, workspace, 4
  bind = $Mod, 5, workspace, 5
  bind = $Mod, 6, workspace, 6
  bind = $Mod, 7, workspace, 7
  bind = $Mod, 8, workspace, 8
  bind = $Mod, 9, workspace, 9
  bind = $Mod, 0, workspace, 10
  bind = $Mod, period, workspace, e+1
  bind = $Mod, comma, workspace, e-1
  
  ##################
  ###    MOVE    ###
  ##################
  bind = $Mod_S, 1, movetoworkspace, 1
  bind = $Mod_S, 2, movetoworkspace, 2
  bind = $Mod_S, 3, movetoworkspace, 3
  bind = $Mod_S, 4, movetoworkspace, 4
  bind = $Mod_S, 5, movetoworkspace, 5
  bind = $Mod_S, 6, movetoworkspace, 6
  bind = $Mod_S, 7, movetoworkspace, 7
  bind = $Mod_S, 8, movetoworkspace, 8
  bind = $Mod_S, 9, movetoworkspace, 9
  bind = $Mod_S, 0, movetoworkspace, 10
  
  
  #####################
  ### MOUSE BINDING ###
  #####################
  bindm = $Mod, mouse:272, movewindow
  bindm = $Mod, mouse:273, resizewindow
  bind = SUPER, mouse_down, workspace, e+1
  bind = SUPER, mouse_up, workspace, e-1
''
