{
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./min-packages.nix ];
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      ## term

      podman
      git-filter-repo
      just
      stow
      trash-cli
      emacs
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
      ;

    inherit (pkgs.nodePackages_latest)
      nodejs
      npm
      ;
  };
}
