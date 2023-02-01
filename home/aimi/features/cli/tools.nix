{ pkgs, ... }: {
  ## Autojump
  programs.autojump.enable = true;

  home.packages  = with pkgs; [
    # tool to get fetchers(fetchgit, ...) info
    nurl 

    # replacement of grep
    ripgrep-all
  ];
}
