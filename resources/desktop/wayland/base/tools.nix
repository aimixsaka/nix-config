{ pkgs, ... }: {
  home.packages = with pkgs; [
    ## screenshot
    grim
    slurp
    swappy
    wl-clipboard
    wf-recorder

    ## screen sharing
    pipewire
    pamixer
    wireplumber

    swaybg  
    swaylock
  ];
}
