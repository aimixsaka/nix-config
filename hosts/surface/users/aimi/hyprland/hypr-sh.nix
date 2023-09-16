{
  home.file."hypr.sh" = {
    # set this to false to disable 
    # auto generate for this file.
    # default is true
    #enable = false;

    executable = true;
    text = ''
      export QT_STYLE_OVERRIDE=kvantum 

      exec Hyprland
    '';
  };
}
