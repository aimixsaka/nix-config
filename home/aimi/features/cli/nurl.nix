{ pkgs, ... }: {
  home.packages  = with pkgs; [
    # tool to get fetchers(fetchgit, ...) info
    nurl 
  ];
}
