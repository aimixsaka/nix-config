{
  lib,
  pkgs,
  ...
}: {
  imports = [./min-packages.nix];
  # TODO: move most package to user level.
  environment.systemPackages = lib.attrValues {
    inherit
      (pkgs)
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
      android-studio
      google-chrome
      ;

    #androidsdk =
    #  (pkgs.androidenv.composeAndroidPackages {
    #    platformVersions = [
    #      "33"
    #      "34"
    #      "35"
    #    ];
    #    abiVersions = ["armeabi-v7a" "arm64-v8a"];
    #    includeNDK = true;
    #  })
    #  .androidsdk;
    inherit
      (pkgs.nodePackages_latest)
      nodejs
      npm
      ;
  };
}
