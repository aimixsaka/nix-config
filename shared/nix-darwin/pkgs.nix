{ pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    lib.flatten (
      lib.attrValues {

        build = [
          # emacs need statically compiled glibtool
          (libtool.overrideAttrs (_: {
            dontDisableStatic = true;
            # libtool -> glibtool
            configureFlags = [ "--program-prefix=g" ];
          }))
        ];

        net = [ darwin.iproute2mac ];

        apps = [
          (emacs-pgtk.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [
              # Fix OS window role (needed for window managers like yabai)
              (fetchpatch {
                url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/fix-window-role.patch";
                sha256 = "sha256-+z/KfsBm1lvZTZNiMbxzXQGRTjkCFO4QPlEK35upjsE=";
              })
              # Use poll instead of select to get file descriptors
              (fetchpatch {
                url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-30/poll.patch";
                sha256 = "sha256-bQW9LPmJhMAtP2rftndTdjw0uipPyOp5oXqtIcs7i/Q=";
              })
              # Enable rounded window with no decoration
              (fetchpatch {
                url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-30/round-undecorated-frame.patch";
                sha256 = "sha256-uYIxNTyfbprx5mCqMNFVrBcLeo+8e21qmBE3lpcnd+4=";
              })
              # Make Emacs aware of OS-level light/dark mode
              (fetchpatch {
                url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-30/system-appearance.patch";
                sha256 = "sha256-3QLq91AQ6E921/W9nfDjdOUWR8YVsqBAT/W9c1woqAw=";
              })
            ];
          }))
        ];

      }
    );
}
