{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      ## build

      gcc
      clang
      cmake
      gnumake
      pkg-config
      meson
      ninja
      ## editor

      vis
      neovim
      ## lang

      python3
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
      tree
      htop
      parallel
      unzip
      gdb
      pciutils
      ;
  };
}
