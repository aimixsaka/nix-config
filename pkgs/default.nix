{
  pkgs ? import <nixpkgs> { },
}:
rec {
  pydle = pkgs.python312Packages.callPackage ./pydle { };
  telegramirc = pkgs.callPackage ./telegramirc.nix { inherit pydle; };
}
