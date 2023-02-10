{ pkgs, ... }: {
  home.packages = with pkgs; [
    ## icons
    # default fallback icon theme
    hicolor-icon-theme
    numix-icon-theme
  ];
}
