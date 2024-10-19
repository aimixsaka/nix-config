{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      ## build
      cmake
      pkg-config

      ## editor
      neovim
      emacs

      ## text
      jq
      ripgrep

      ## term
      file
      binutils
      git
      git-lfs
      tmux
      fzf
      just
      tree
      htop
      parallel
      unzip

      gdb

      pciutils
      ;
  };
}
