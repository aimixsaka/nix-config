{ pkgs, ... }: {
  ## Autojump
  programs.autojump.enable = true;
  ## git
  programs.git.enable = true;

  home.packages  = with pkgs; [
    # tool to get fetchers(fetchgit, ...) info
    nurl 
    # auto script on directory change
    direnv
    # replacement of grep
    ripgrep-all
    # gpg
    gnupg
    # include killall, pstree, ...
    psmisc
  ];
}
