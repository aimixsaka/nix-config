{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      ##################################
      ####### window management #######
      ##################################

      # focus window
      lalt - h : yabai -m window --focus west
      lalt - l : yabai -m window --focus east
      lalt - j : yabai -m window --focus south
      lalt - k : yabai -m window --focus north

      # swap window
      shift + lalt - h : yabai -m window --swap west
      shift + lalt - l : yabai -m window --swap east
      shift + lalt - j : yabai -m window --swap south
      shift + lalt - k : yabai -m window --swap north

      # balance size of windows
      shift + lalt - 0 : yabai -m space --balance

      # increase window size
      ctrl + lalt - h : yabai -m window --resize left:-20:0
      ctrl + lalt - l : yabai -m window --resize left:+20:0

      # decrease window size
      ctrl + lalt - k : yabai -m window --resize bottom:0:-20
      ctrl + lalt - j : yabai -m window --resize bottom:0:+20

      # toggle window zoom
      lalt - d : yabai -m window --toggle zoom-parent
      lalt - f : yabai -m window --toggle zoom-fullscreen

      # toggle window float
      shift + lalt - space : yabai -m window --toggle float --grid 4:4:1:1:2:2


      # move window to specific space
      shift + lalt - 1 : yabai -m window --space 1
      shift + lalt - 2 : yabai -m window --space 2
      shift + lalt - 3 : yabai -m window --space 3
      shift + lalt - 4 : yabai -m window --space 4

      #########################
      ###### space command ####
      #########################
      # focus specific space
      lalt - 1 : yabai -m space --focus 1
      lalt - 2 : yabai -m space --focus 2
      lalt - 3 : yabai -m space --focus 3

      # lalt - .
      lalt - 0x2B : yabai -m space --focus prev
      # lalt - ,
      lalt - 0x2F : yabai -m space --focus next

      #########################
      ###### exec command ####
      #########################

      lalt - return : alacritty
    '';
  };
}
