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
      janet
      zig
      ghc
      racket
      guile
      sbcl
      ## lsp

      nil
      zls
      pyright

      ## formatter
      nixfmt
      ## net

      networkmanager
      ## app

      flameshot
      vscode
      qbittorrent
      pandoc
      qemu
      telegram-desktop
      gopeed
      qq
      netease-cloud-music-gtk
      google-chrome
      ;

    inherit (pkgs.nodePackages_latest)
      nodejs
      npm
      ;

    inherit (pkgs.gst_all_1)
      # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
      gstreamer
      # Common plugins like "filesrc" to combine within e.g. gst-launch
      gst-plugins-base
      # Specialized plugins separated by quality
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      # Plugins to reuse ffmpeg to play almost every video format
      gst-libav
      # Support the Video Audio (Hardware) Acceleration API
      gst-vaapi
      ;

    inherit (pkgs.llvmPackages)
      clang-tools
      ;
  };
}
