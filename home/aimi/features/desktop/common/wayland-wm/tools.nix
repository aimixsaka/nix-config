{ pkgs, ... }: {
  home.packages = with pkgs; [
    # light control
    wlsunset

    ## screenshot
    grim
    slurp
    wl-clipboard
    wf-recorder
    ## another choice for change img
    swappy
    ## screen sharing
    pipewire
    pamixer
    wireplumber
  ];
}
