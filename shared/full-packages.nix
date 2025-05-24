{
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./min-packages.nix ];
  # TODO: move most package to user level.
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      ## term

      podman
      git-filter-repo
      just
      stow
      trash-cli
      emacs
      megatools
      ## db

      sqlite
      ## languages

      pdm
      go
      rustup
      zig
      ghc
      racket
      guile
      sbcl
      ## lsp

      nil
      zls
      pyright
      ## net

      networkmanager
      ## app

      vscode
      pandoc
      qemu
      telegram-desktop
      qq
      ;

    inherit (pkgs.nodePackages_latest)
      nodejs
      npm
      ;
  };
}
