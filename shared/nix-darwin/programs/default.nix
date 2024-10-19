{
  imports = [
    #./skhd.nix
    #./yabai.nix
    ./homebrew.nix
    ./nix-index-database.nix
  ];

  # needed for multi user install
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
}
