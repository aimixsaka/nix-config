{ pkgs, ... }: {

  home.packages = with pkgs; [
    ## for nm-applet.
    ## Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
    #at-spi2-atk
    # for notification
    libnotify
    # file exploer
    ranger
    # vedio
    mpv
    ## image viewer
    geeqie
    ## markdown viewer
    marktext
    ## use appimage-run to run .AppImage file
    appimage-run
    wineWowPackages.stable
    # screen sharing
    obs-studio
    # xdg-open and a lot
    xdg-utils
    # virtual machine
    qemu

    #idea
    #jetbrains.idea-ultimate
  ];
}

